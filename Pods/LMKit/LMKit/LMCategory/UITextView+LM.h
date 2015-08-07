//
//  UITextView+LM.h
//  LMCategory
//
//  Created by 李蒙 on 15/7/9.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (LM)

/**
 *  限制输入长度
 *
 *  @param length 限制长度值
 */
- (void)lm_limitLength:(NSUInteger)length;

/**
 *  Placeholder
 *
 *  @param placeholer 占位提示
 */
- (void)lm_placeholder:(NSString *)placeholder;;

@end
