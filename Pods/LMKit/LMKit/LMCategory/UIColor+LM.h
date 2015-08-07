//
//  UIColor+LM.h
//  LMCategory
//
//  Created by 李蒙 on 15/7/13.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LMColorWithHex(hex) [UIColor lm_colorWithHex:hex]
#define LMColorWithHexA(hex,a) [UIColor lm_colorWithHex:hex alpha:a]
#define LMColorWithHexString(hexString) [UIColor lm_colorWithHexString:hexString]
#define LMColorWithRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define LMColorWithRGB(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]
#define LMColorWithRamdom [UIColor lm_colorWithRamdom];

@interface UIColor (LM)

/**
 *  16进制转为UIColor
 *
 *  @param hex 16进制数
 *
 *  @return UIColor
 */
+ (UIColor *)lm_colorWithHex:(NSUInteger)hex;

/**
 *  16进制转为UIColor
 *
 *  @param hex   16进制数
 *  @param alpha 透明度
 *
 *  @return UIColor
 */
+ (UIColor *)lm_colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha;

/**
 *  16进制字符串转为UIColor
 *
 *  @param hexString e.g.@"ff", @"#fff", @"ff0000",  @"ff00ffcc"
 *
 *  @return UIColor
 */
+ (UIColor *)lm_colorWithHexString:(NSString *)hexString;

/**
 *  产生随机颜色
 *
 *  @return 随机色
 */
+ (UIColor *)lm_colorWithRamdom;

@end
