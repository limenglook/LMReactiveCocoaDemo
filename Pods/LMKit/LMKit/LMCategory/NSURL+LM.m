//
//  NSURL+LM.m
//  LMCategory
//
//  Created by 李蒙 on 15/7/21.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "NSURL+LM.h"
#import "LMKit.h"
#import <netinet/in.h>
#import <SystemConfiguration/SCNetworkReachability.h>

@implementation NSURL (LM)

#pragma mark 判断网络是否可用

+ (BOOL)lm_networkReachability
{
    struct sockaddr_in initAddress;
    bzero(&initAddress, sizeof(initAddress));
    initAddress.sin_len = sizeof(initAddress);
    initAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef readRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&initAddress);
    SCNetworkReachabilityFlags flags;
    BOOL getRetrieveFlags = SCNetworkReachabilityGetFlags(readRouteReachability, &flags);
    CFRelease(readRouteReachability);
    
    if (!getRetrieveFlags) {
        
        return NO;
    }
    
    BOOL flagsReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL connectionRequired = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    
    return (flagsReachable && !connectionRequired) ? YES : NO;
}

#pragma mark 请求参数

- (NSDictionary *)lm_requestParams
{
    return [self query].lm_requestParams;
}

@end
