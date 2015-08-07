//
//  NSArray+LM.m
//  LMCategory
//
//  Created by 李蒙 on 15/7/17.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "NSArray+LM.h"

@implementation NSArray (LM)

- (NSString *)descriptionWithLocale:(id)locale {
    
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    
    [strM appendString:@")"];
    
    return strM;
}

@end
