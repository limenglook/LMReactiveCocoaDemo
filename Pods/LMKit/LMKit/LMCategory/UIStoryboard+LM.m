//
//  UIStoryboard+LM.m
//  LMCategory
//
//  Created by 李蒙 on 15/7/20.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "UIStoryboard+LM.h"

@implementation UIStoryboard (LM)

#pragma mark 快速创建ViewController

+ (id)lm_storyboardWithName:(NSString *)name instantiateViewControllerWithIdentifier:(NSString *)identifier {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:name bundle:[NSBundle mainBundle]];
    
    return [storyboard instantiateViewControllerWithIdentifier:identifier];
}

#pragma mark 快速创建ViewController(Is InitialViewController)

+ (id)lm_initialViewControllerWithStoryboardName:(NSString *)name {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:name bundle:[NSBundle mainBundle]];
    
    return [storyboard instantiateInitialViewController];
}

#pragma mark 快速创建ViewController(Main Stroyboard && Is InitialViewController)

+ (id)lm_initialViewController {
    
    return [UIStoryboard lm_initialViewControllerWithStoryboardName:@"Main"];
}

#pragma mark 快速创建ViewController(Main Stroyboard)

+ (id)lm_mainStoryboardInstantiateViewControllerWithIdentifier:(NSString *)identifier {
    
    return[UIStoryboard lm_storyboardWithName:@"Main" instantiateViewControllerWithIdentifier:identifier];
}

@end
