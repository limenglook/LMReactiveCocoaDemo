//
//  UIViewController+LMPlaceholderView.h
//  LMPlaceholderView
//
//  Created by 李蒙 on 15/6/29.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RefreshBlock)();

@interface UIViewController (LMPlaceholderView)

- (void)lm_showPlaceholderInitWithBackgroundColor:(UIColor *)color imageName:(NSString *)imageName andTitle:(NSString *)title andRefresBlock:(RefreshBlock)block;

- (void)lm_showPlaceholderInitWithBackgroundColor:(UIColor *)color imageName:(NSString *)imageName andTitle:(NSString *)title andFrame:(CGRect)frame andRefresBlock:(RefreshBlock)block;

- (void)lm_showPlaceholderInitWithImageName:(NSString *)imageName andTitle:(NSString *)title andRefresBlock:(RefreshBlock)block;

- (void)lm_showPlaceholderInitWithImageName:(NSString *)imageName andTitle:(NSString *)title andFrame:(CGRect)frame andRefresBlock:(RefreshBlock)block;

- (void)lm_hidePlaceholder;

@end
