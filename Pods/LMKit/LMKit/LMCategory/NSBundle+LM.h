//
//  NSBundle+LM.h
//  LMCategory
//
//  Created by 李蒙 on 15/7/3.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LMAppName [NSBundle lm_appName]
#define LMAppIdentifier [NSBundle lm_appIdentifier]
#define LMAppVersion [NSBundle lm_appVersion]
#define LMAppBuild [NSBundle lm_appBuild]

@interface NSBundle (LM)

/**
 *  获取应用名称
 *
 *  @return 当前应用名称
 */
+ (NSString *)lm_appName;

/**
 *  获取应用Identifier
 *
 *  @return 当前应用Identifier
 */
+ (NSString *)lm_appIdentifier;

/**
 *  获取应用Version
 *
 *  @return 当前应用Version
 */
+ (NSString *)lm_appVersion;

/**
 *  获取应用Bulid
 *
 *  @return 当前应用Bulid
 */
+ (NSString *)lm_appBuild;

@end
