//
//  UIDevice+LM.h
//  LMCategory
//
//  Created by 李蒙 on 15/7/3.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LMUUIDCreat [UIDevice lm_UUIDCreate]
#define LMSystemName [UIDevice lm_systemName]
#define LMSystemVersion [UIDevice lm_systemVersion]
#define LMDeviceModelName [UIDevice lm_deviceModelName]

@interface UIDevice (LM)

/**
 *  创建UUID(通用唯一识别码)
 *
 *  @return 通用唯一标识符
 */
+ (NSString *)lm_UUIDCreate;

/**
 *  获取系统名称
 *
 *  @return 系统名称(iPhone OS)
 */
+ (NSString *)lm_systemName;

/**
 *  获取系统版本号
 *
 *  @return 系统版本号(8.4)
 */
+ (NSString *)lm_systemVersion;

/**
 *  获取设备型号
 *
 *  @return 设备型号(iPhone 6 Plus)
 */
+ (NSString *)lm_deviceModelName;

@end
