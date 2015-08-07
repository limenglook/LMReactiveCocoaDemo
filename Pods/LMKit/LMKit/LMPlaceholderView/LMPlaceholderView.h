//
//  LMPlaceholderView.h
//  LMPlaceholderView
//
//  Created by 李蒙 on 15/6/29.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMPlaceholderView : UIView

- (void)lm_showViewWithImageName:(NSString *)imageName andTitle:(NSString *)title;

- (void)lm_hide;

@end
