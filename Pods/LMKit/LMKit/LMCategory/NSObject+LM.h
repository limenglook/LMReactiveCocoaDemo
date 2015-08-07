//
//  NSObject+LM.h
//  LMCategory
//
//  Created by 李蒙 on 15/7/18.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LMRandomChinese(length) [self lm_randomChinese:length]
#define LMRandomEnglish(length) [self lm_randomEnglish:length]

@interface NSObject (LM)

/**
 *  随机Integer
 *
 *  @param from 包括from
 *  @param to   包括to
 *
 *  @return NSInteger
 */
- (NSInteger)lm_randomInteger:(NSInteger)from to:(NSInteger)to;

/**
 *  随机大写字母
 *
 *  @param length 长度
 *
 *  @return 字母
 */
- (NSString *)lm_randomEnglish:(NSUInteger)length;

/**
 *  随机汉字
 *
 *  @param length 长度
 *
 *  @return 汉字
 */
- (NSString *)lm_randomChinese:(NSUInteger)length;

/**
*  自定义对象归档(需要实现<NSCoding>协议)
*
*  @param path 路径
*  @param key  key
*
*  @return 是否成功
*/
- (BOOL)lm_archiverDataWriteToFile:(NSString *)path forKey:(NSString *)key;

/**
 *  自定义对象归档(需要实现<NSCoding>协议)
 *
 *  @param path 路径
 *  @param key  key
 *  @param AESkey AES密钥(加密、解密密钥必须一致)
 *
 *  @return 是否成功
 */
- (BOOL)lm_archiverDataWriteToFile:(NSString *)path forKey:(NSString *)key AESKey:(NSString *)AESkey;

/**
 *  自定义对象解档(需要实现<NSCoding>协议)
 *
 *  @param path 路径
 *  @param key  key
 *
 *  @return 自定义对象
 */
+ (id)lm_unarchiverFile:(NSString *)path decodeObjectForKey:(NSString *)key;

/**
 *  自定义对象解档(需要实现<NSCoding>协议)
 *
 *  @param path 路径
 *  @param key  key
 *  @param AESkey AES密钥
 *
 *  @return 自定义对象
 */
+ (id)lm_unarchiverFile:(NSString *)path decodeObjectForKey:(NSString *)key AESKey:(NSString *)AESkey;

/**
 *  延时执行
 *
 *  @param block 方法
 *  @param delay 秒
 */
- (void)lm_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;

/**
 *  延时执行
 *
 *  @param block  方法
 *  @param object 参数
 *  @param delay  秒
 */
- (void)lm_performBlock:(void (^)(id arg))block withObject:(id)object afterDelay:(NSTimeInterval)delay;

/**
 *  对象转为字典
 *
 *  @return NSDictionary(空值忽略)
 */
- (NSDictionary *)lm_dictionaryProperty;

/**
 *  计算需要耗费的时间(秒)
 *
 *  @param block  方法
 *  @param prefix 方法标识
 */
- (NSTimeInterval)lm_logTimeToRunBlock:(void (^)(void))block withPrefix:(NSString *)prefix;

@end
