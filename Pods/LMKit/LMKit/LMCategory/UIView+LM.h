//
//  UIView+LM.h
//  LMCategory
//
//  Created by 李蒙 on 15/7/21.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^lm_TapGestureBlock)(UITapGestureRecognizer *gestureRecognizer);
typedef void(^lm_LongPressGestureBlock)(UILongPressGestureRecognizer *gestureRecognizer);
typedef void(^lm_PanGestureBlock)(UIPanGestureRecognizer *gestureRecognizer);

@interface UIView (LM)

/**
 *  TapGesture回调
 *
 *  @param panAction lm_TapGestureBlock
 *
 *  @return UITapGestureRecognizer
 */
- (UITapGestureRecognizer *)lm_addTapGesture:(lm_TapGestureBlock)tapAction;

/**
 *  LongPressGesture回调
 *
 *  @param panAction lm_LongPressGestureBlock
 *
 *  @return UILongPressGestureRecognizer
 */
- (UILongPressGestureRecognizer *)lm_addLongPressGesture:(lm_LongPressGestureBlock)longPressAction;

/**
 *  PanGesture回调
 *
 *  @param panAction lm_GestureBlock
 *
 *  @return UIPanGestureRecognizer
 */
- (UIPanGestureRecognizer *)lm_addPanGesture:(lm_PanGestureBlock)panAction;

/**
 *  shakeView
 */
- (void)lm_shakeAnimation;

/**
 *  popAnimation
 */
- (void)lm_popAnimation;

@end
