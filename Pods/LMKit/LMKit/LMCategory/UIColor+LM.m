//
//  UIColor+LM.m
//  LMCategory
//
//  Created by 李蒙 on 15/7/13.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "UIColor+LM.h"

@implementation UIColor (LM)

#pragma mark 16进制转为UIColor

+ (UIColor *)lm_colorWithHex:(NSUInteger)hex
{
    return [UIColor lm_colorWithHex:hex alpha:1.0];
}

+ (UIColor *)lm_colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:alpha];
}

#pragma mark 16进制字符串转为UIColor

+ (UIColor *)lm_colorWithHexString:(NSString *)hexString
{
    if (![hexString isKindOfClass:[NSString class]] || [hexString length] == 0) {
        
        return [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f];
    }
    
    const char *s = [hexString cStringUsingEncoding:NSASCIIStringEncoding];
    
    if (*s == '#') {
        ++s;
    }
    
    unsigned long long value = strtoll(s, nil, 16);
    int r, g, b, a;
    
    switch (strlen(s)) {
        case 2:
            // xx
            r = g = b = (int)value;
            a = 255;
            break;
        case 3:
            // RGB
            r = ((value & 0xf00) >> 8);
            g = ((value & 0x0f0) >> 4);
            b = ((value & 0x00f) >> 0);
            r = r * 16 + r;
            g = g * 16 + g;
            b = b * 16 + b;
            a = 255;
            break;
        case 6:
            // RRGGBB
            r = (value & 0xff0000) >> 16;
            g = (value & 0x00ff00) >>  8;
            b = (value & 0x0000ff) >>  0;
            a = 255;
            break;
        default:
            // RRGGBBAA
            r = (value & 0xff000000) >> 24;
            g = (value & 0x00ff0000) >> 16;
            b = (value & 0x0000ff00) >>  8;
            a = (value & 0x000000ff) >>  0;
            break;
    }
    
    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:a / 255.0f];
}

#pragma mark 产生随机颜色

+ (UIColor *)lm_colorWithRamdom
{
    return [UIColor colorWithRed:arc4random_uniform(256) / 255.0f green:arc4random_uniform(256) / 255.0f blue:arc4random_uniform(256) / 255.0f alpha:1.0f];
}

@end
