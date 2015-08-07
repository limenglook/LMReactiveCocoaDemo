//
//  NSBundle+LM.m
//  LMCategory
//
//  Created by 李蒙 on 15/7/3.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "NSBundle+LM.h"

@implementation NSBundle (LM)

#pragma mark 获取应用名称

+ (NSString *)lm_appName
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
}

#pragma mark 获取应用Identifier

+ (NSString *)lm_appIdentifier
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

#pragma mark 获取应用Version

+ (NSString *)lm_appVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

#pragma mark 获取应用Bulid

+ (NSString *)lm_appBuild
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

@end
