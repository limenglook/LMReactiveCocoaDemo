//
//  UIStoryboard+LM.h
//  LMCategory
//
//  Created by 李蒙 on 15/7/20.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LMInitialStoryboardName(name) [UIStoryboard lm_initialViewControllerWithStoryboardName:name]
#define LMInitialStoryboardNameIdentifier(name, identifier) [UIStoryboard lm_storyboardWithName:name instantiateViewControllerWithIdentifier:identifier]
#define LMInitialViewController [UIStoryboard lm_initialViewController]
#define LMMainStoryboardIdentifier(identifier) [UIStoryboard lm_mainStoryboardInstantiateViewControllerWithIdentifier:identifier]

@interface UIStoryboard (LM)

/**
 *  快速创建ViewController
 *
 *  @param name       Storyboard Name
 *  @param identifier Storyboard ID
 *
 *  @return id
 */
+ (id)lm_storyboardWithName:(NSString *)name instantiateViewControllerWithIdentifier:(NSString *)identifier;

/**
 *  快速创建ViewController(Is InitialViewController)
 *
 *  @param name storyboard Name
 *
 *  @return id
 */
+ (id)lm_initialViewControllerWithStoryboardName:(NSString *)name;

/**
 *  快速创建ViewController(Main Stroyboard && Is InitialViewController)
 *
 *  @return id
 */
+ (id)lm_initialViewController;

/**
 *  快速创建ViewController(Main Stroyboard)
 *
 *  @param identifier Storyboard ID
 *
 *  @return id
 */
+ (id)lm_mainStoryboardInstantiateViewControllerWithIdentifier:(NSString *)identifier;

@end
