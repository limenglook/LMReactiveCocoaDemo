//
//  NSString+LM.m
//  LMCategory
//
//  Created by 李蒙 on 15/7/3.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "NSString+LM.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (LM)

#pragma mark MD5

- (NSString *)lm_md5
{
    const char *input = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *md5 = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        
        [md5 appendFormat:@"%02x", result[i]];
    }
    
    return md5;
}

#pragma mark SHA1

- (NSString *)lm_sha1
{
    const char *cStr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cStr length:self.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString *sha1 = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        
        [sha1 appendFormat:@"%02x", digest[i]];
    }
    
    return sha1;
}

#pragma mark -.-

- (BOOL)validWithRegex:(NSString *)regex
{
    if (!self || !self.length) {
        
        return false;
    }
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if (![pred evaluateWithObject:self]) {
        
        return false;
    }
    
    return true;
}

#pragma mark 判断输入0-9数字

- (BOOL)lm_validNumber
{
    return [self validWithRegex:@"^[0-9]*$"];
}

#pragma mark 判断手机号

/**
 *
 运营商手机号段划分
 
 中国移动：134（0-8）、135、136、137、138、139、147、150、151、152、154、157、158、159、178、182、183、184、187、188
 中国联通：130、131、132、145、155、156、176、185、186
 中国电信：133、1349、153、177、180、181、189
 网络运营商：170
 *
 *  @return 是/不是
 */
- (BOOL)lm_validMobile
{
    return [self validWithRegex:@"^(0|86|17951)?(13[0-9]|15[0-9]|17[0678]|18[0-9]|14[57])[0-9]{8}$"];
}

#pragma mark 判断身份证号

- (BOOL)lm_validIdentityCard
{
    return [self chk18PaperId:[self uppercaseString]];
}

- (BOOL)chk18PaperId:(NSString *)sPaperId
{
    //  判断位数
    
    if ([sPaperId length] != 15 && [sPaperId length] != 18) {
        
        return NO;
    }
    
    NSString *carid = sPaperId;
    
    long lSumQT = 0;
    
    //  加权因子
    
    int R[] = {7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2};
    
    //  校验码
    
    unsigned char sChecker[11] = {'1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2'};
    
    //  将15位身份证号转换成18位
    
    NSMutableString *mString = [NSMutableString stringWithString:sPaperId];
    
    if ([sPaperId length] == 15) {
        
        [mString insertString:@"19" atIndex:6];
        
        long p = 0;
        
        const char *pid = [mString UTF8String];
        
        for (int i = 0; i <= 16; i++) {
            
            p += (pid[i] - 48) * R[i];
        }
        
        int o = p % 11;
        
        NSString *string_content = [NSString stringWithFormat:@"%c", sChecker[o]];
        
        [mString insertString:string_content atIndex:[mString length]];
        
        carid = mString;
    }
    
    //  判断地区码
    
    NSString *sProvince = [carid substringToIndex:2];
    
    if (![self areaCode:sProvince]) {
        
        return NO;
    }
    
    //  判断年月日是否有效
    
    //  年份
    
    int strYear = [[self getStringWithRange:carid Value1:6 Value2:4] intValue];
    
    //  月份
    
    int strMonth = [[self getStringWithRange:carid Value1:10 Value2:2] intValue];
    
    //  日
    
    int strDay = [[self getStringWithRange:carid Value1:12 Value2:2] intValue];
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    [dateFormatter setTimeZone:localZone];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01", strYear, strMonth, strDay]];
    
    if (!date) {
        
        return NO;
    }
    
    const char *PaperId = [carid UTF8String];
    
    //检验长度
    
    if (18 != strlen(PaperId)) {
        
        return - 1;
    }
    
    //校验数字
    
    for (int i = 0; i < 18; i++) {
        
        if (!isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i)) {
            
            return NO;
        }
    }
    
    //验证最末的校验码
    
    for (int i = 0; i <= 16; i++) {
        
        lSumQT += (PaperId[i] - 48) * R[i];
    }
    
    if (sChecker[lSumQT % 11] != PaperId[17]) {
        
        return NO;
    }
    
    return YES;
}

- (NSString *)getStringWithRange:(NSString *)str Value1:(NSInteger)value1 Value2:(NSInteger)value2;
{
    return [str substringWithRange:NSMakeRange(value1, value2)];
}

- (BOOL)areaCode:(NSString *)code
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setObject:@"北京" forKey:@"11"];
    
    [dic setObject:@"天津" forKey:@"12"];
    
    [dic setObject:@"河北" forKey:@"13"];
    
    [dic setObject:@"山西" forKey:@"14"];
    
    [dic setObject:@"内蒙古" forKey:@"15"];
    
    [dic setObject:@"辽宁" forKey:@"21"];
    
    [dic setObject:@"吉林" forKey:@"22"];
    
    [dic setObject:@"黑龙江" forKey:@"23"];
    
    [dic setObject:@"上海" forKey:@"31"];
    
    [dic setObject:@"江苏" forKey:@"32"];
    
    [dic setObject:@"浙江" forKey:@"33"];
    
    [dic setObject:@"安徽" forKey:@"34"];
    
    [dic setObject:@"福建" forKey:@"35"];
    
    [dic setObject:@"江西" forKey:@"36"];
    
    [dic setObject:@"山东" forKey:@"37"];
    
    [dic setObject:@"河南" forKey:@"41"];
    
    [dic setObject:@"湖北" forKey:@"42"];
    
    [dic setObject:@"湖南" forKey:@"43"];
    
    [dic setObject:@"广东" forKey:@"44"];
    
    [dic setObject:@"广西" forKey:@"45"];
    
    [dic setObject:@"海南" forKey:@"46"];
    
    [dic setObject:@"重庆" forKey:@"50"];
    
    [dic setObject:@"四川" forKey:@"51"];
    
    [dic setObject:@"贵州" forKey:@"52"];
    
    [dic setObject:@"云南" forKey:@"53"];
    
    [dic setObject:@"西藏" forKey:@"54"];
    
    [dic setObject:@"陕西" forKey:@"61"];
    
    [dic setObject:@"甘肃" forKey:@"62"];
    
    [dic setObject:@"青海" forKey:@"63"];
    
    [dic setObject:@"宁夏" forKey:@"64"];
    
    [dic setObject:@"新疆" forKey:@"65"];
    
    [dic setObject:@"台湾" forKey:@"71"];
    
    [dic setObject:@"香港" forKey:@"81"];
    
    [dic setObject:@"澳门" forKey:@"82"];
    
    [dic setObject:@"国外" forKey:@"91"];
    
    if (![dic objectForKey:code]) {
        
        return NO;
    }
    
    return YES;
}

#pragma mark 判断URL

- (BOOL)lm_validURL
{
    return [self validWithRegex:@"^((http)|(https))+:[^\\s]+\\.[^\\s]*$"];
}

#pragma mark 判断EMail

- (BOOL)lm_validEMail
{
    return [self validWithRegex:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
}

#pragma mark 判断IP

- (BOOL)lm_validIPAddress
{
    if ([self validWithRegex:@"^(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})$"]) {
        
        NSArray *components = [self componentsSeparatedByString:@"."];
        
        for (NSString *s in components) {
            
            if (s.integerValue > 255) {
                
                return NO;
            }
        }
        
        return YES;
    }
    
    return NO;
}

#pragma mark 判断汉字

- (BOOL)lm_validChinese
{
    return [self validWithRegex:@"^[\u4e00-\u9fa5]+$"];
}

#pragma mark - -.-

#pragma mark 计算Size

- (CGSize)lm_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    CGSize resultSize = CGSizeZero;
    
    if (self.length <= 0) {
        return resultSize;
    }
    
    resultSize = [self boundingRectWithSize:size options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName: font} context:nil].size;
    
    return resultSize;
}

#pragma mark 计算Width

- (CGFloat)lm_widthWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    return [self lm_sizeWithFont:font constrainedToSize:size].width;
}

#pragma mark 计算Height

- (CGFloat)lm_heightWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    return [self lm_sizeWithFont:font constrainedToSize:size].height;
}

#pragma mark - -.-

#pragma mark 返回沙盒中的文件路径

- (NSString *)lm_documentsFile
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:self];
}

#pragma mark 删除沙盒中的文件

- (BOOL)lm_removeDocumentsFile
{
    return [[NSFileManager defaultManager] removeItemAtPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:self] error:nil];
}

#pragma mark 写入系统偏好

- (BOOL)lm_saveUserDefaultsWithKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:self forKey:key];
    
    return [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark 获取系统偏好值

- (NSString *)lm_getUserDefaults
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:self];
}

#pragma mark - -.-

#pragma mark 去掉字符串两端的空白

- (NSString *)lm_trimWhitespace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

#pragma mark 去掉字符串两端的空白和回车字符

- (NSString *)lm_trimWhitespaceAndNewline
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark 去掉字符串所有的空白字符

- (NSString *)lm_trimWhitespaceAll
{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

#pragma mark 字符串反转

- (NSString *)lm_reverse
{
    NSMutableString *reverseString = [[NSMutableString alloc] init];
    
    NSInteger charIndex = [self length];
    
    while (charIndex > 0) {
        
        charIndex--;
        NSRange subStringRange = NSMakeRange(charIndex, 1);
        [reverseString appendString:[self substringWithRange:subStringRange]];
    }
    
    return reverseString;
}

#pragma mark 是否包含字符串

- (BOOL)lm_containsString:(NSString *)aString
{
    NSRange rang = [self rangeOfString:aString];
    
    if (rang.location == NSNotFound) {
        
        return NO;
        
    } else {
        
        return YES;
    }
}

#pragma mark - -.-

#pragma mark URLEncode

- (NSURL *)lm_urlEncode
{
    return [NSURL URLWithString:[self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

#pragma mark - 请求参数

- (NSDictionary *)lm_requestParams
{
    NSArray *pairs = [self componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    for (NSString *pair in pairs) {
        
        NSArray *object = [pair componentsSeparatedByString:@"="];
        NSString *key = [[object objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [params setObject:key forKey:[object objectAtIndex:0]];
    }
    
    return params;
}

#pragma mark Encode

- (NSString *)lm_encode
{
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
    
    return encodedString;
}

#pragma mark Decode

- (NSString *)lm_decode
{
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)self, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
}

#pragma mark - -.-

#pragma mark - pinyin

- (NSString *)lm_pinyinWithPhoneticSymbol
{
    NSMutableString *pinyin = [NSMutableString stringWithString:self];
    
    CFStringTransform((__bridge CFMutableStringRef)(pinyin), NULL, kCFStringTransformMandarinLatin, NO);
    
    return pinyin;
}

- (NSString *)lm_pinyin
{
    NSMutableString *pinyin = [NSMutableString stringWithString:[self lm_pinyinWithPhoneticSymbol]];
    CFStringTransform((__bridge CFMutableStringRef)(pinyin), NULL, kCFStringTransformStripCombiningMarks, NO);
    
    return pinyin;
}

- (NSArray *)lm_pinyinArray
{
    NSArray *array = [[self lm_pinyin] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    return array;
}

- (NSString *)lm_pinyinWithoutBlank
{
    NSMutableString *string = [NSMutableString stringWithString:@""];
    
    for (NSString *str in [self lm_pinyinArray]) {
        
        [string appendString:str];
    }
    
    return string;
}

- (NSArray *)lm_pinyinInitialsArray
{
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSString *str in [self lm_pinyinArray]) {
        
        if ([str length] > 0) {
            
            [array addObject:[str substringToIndex:1]];
        }
    }
    
    return array;
}

- (NSString *)lm_pinyinInitialsString
{
    NSMutableString *pinyin = [NSMutableString stringWithString:@""];
    
    for (NSString *str in [self lm_pinyinArray]) {
        
        if ([str length] > 0) {
            
            [pinyin appendString:[str substringToIndex:1]];
        }
    }
    
    return pinyin;
}

@end
