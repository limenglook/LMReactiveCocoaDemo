//
//  NSURL+LM.h
//  LMCategory
//
//  Created by 李蒙 on 15/7/21.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (LM)

/**
 *  判断网络是否可用
 *
 *  @return 是否
 */
+ (BOOL)lm_networkReachability;

/**
 *  请求参数
 *
 *  @return NSDictionary
 */
- (NSDictionary *)lm_requestParams;

@end
