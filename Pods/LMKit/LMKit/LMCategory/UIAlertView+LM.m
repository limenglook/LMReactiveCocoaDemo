//
//  UIAlertView+LM.m
//  LMCategory
//
//  Created by 李蒙 on 15/7/15.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "UIAlertView+LM.h"

@implementation UIAlertView (LM)

+ (void)lm_showAlertViewWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle
{
    [[[UIAlertView alloc] initWithTitle:title message:nil delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil] show];
}

+ (void)lm_showAlertViewWithTitle:(NSString *)title
{
    [[[UIAlertView alloc] initWithTitle:title message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
}

@end
