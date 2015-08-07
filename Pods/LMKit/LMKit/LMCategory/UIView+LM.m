//
//  UIView+LM.m
//  LMCategory
//
//  Created by 李蒙 on 15/7/21.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "UIView+LM.h"
#import <objc/runtime.h>

@interface UIView ()

@property (copy, nonatomic) lm_TapGestureBlock tapGestureAction;

@property (copy, nonatomic) lm_LongPressGestureBlock longPressGestureAction;

@property (copy, nonatomic) lm_PanGestureBlock panGestureAction;

@end

static char tapGestureBlockKey, longPressGestureBlockKey, panGestureBlockKey;

@implementation UIView (LM)

#pragma mark -.-

- (void)setTapAction:(lm_TapGestureBlock)tapAction {
    
    objc_setAssociatedObject(self, &tapGestureBlockKey, tapAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (lm_TapGestureBlock)tapGestureAction {
    
    return objc_getAssociatedObject(self, &tapGestureBlockKey);
}

- (void)setLongPressGestureAction:(lm_LongPressGestureBlock)longPressGestureAction {
    
    objc_setAssociatedObject(self, &longPressGestureBlockKey, longPressGestureAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (lm_LongPressGestureBlock)longPressGestureAction {
    
    return objc_getAssociatedObject(self, &longPressGestureBlockKey);
}

- (void)setPanGestureAction:(lm_PanGestureBlock)panGestureAction {
    
    objc_setAssociatedObject(self, &panGestureBlockKey, panGestureAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (lm_PanGestureBlock)panGestureAction {
    
    return objc_getAssociatedObject(self, &panGestureBlockKey);
}

#pragma mark TapGesture回调

- (UITapGestureRecognizer *)lm_addTapGesture:(lm_TapGestureBlock)tapAction
{
    self.tapAction = tapAction;
    
    if (![self gestureRecognizers]) {
        
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lm_tapGesture:)];
        [self addGestureRecognizer:tapGesture];
        
        return tapGesture;
    }
    
    return nil;
}

#pragma mark LongPressGesture回调

- (UILongPressGestureRecognizer *)lm_addLongPressGesture:(lm_LongPressGestureBlock)longPressAction
{
    self.longPressGestureAction = longPressAction;
    
    if (![self gestureRecognizers]) {
        
        self.userInteractionEnabled = YES;
        
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(lm_longGesture:)];
        [self addGestureRecognizer:longPressGesture];
        
        return longPressGesture;
    }
    
    return nil;
}

#pragma mark PanGesture回调

- (UIPanGestureRecognizer *)lm_addPanGesture:(lm_PanGestureBlock)panAction
{
    self.panGestureAction = panAction;
    
    if (![self gestureRecognizers]) {
        
        self.userInteractionEnabled = YES;
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(lm_panGesture:)];
        [self addGestureRecognizer:panGesture];
        
        return panGesture;
    }
    
    return nil;
}

- (void)lm_tapGesture:(UITapGestureRecognizer *)gestureRecognizer
{
    if (self.tapGestureAction) {
        
        self.tapGestureAction(gestureRecognizer);
    }
}

- (void)lm_longGesture:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (self.longPressGestureAction) {
        
        self.longPressGestureAction(gestureRecognizer);
    }
}

- (void)lm_panGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    if (self.panGestureAction) {
        
        self.panGestureAction(gestureRecognizer);
    }
}

#pragma mark -.-

- (void)lm_shakeAnimation
{
    CAKeyframeAnimation *shake = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    shake.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-5.0f, 0.0f, 0.0f)], [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(5.0f, 0.0f, 0.0f)]];
    shake.autoreverses = YES;
    shake.repeatCount = 2.0f;
    shake.duration = 0.07f;
    
    [self.layer addAnimation:shake forKey:nil];
}

- (void)lm_popAnimation
{
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)], [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)], [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)], [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    popAnimation.duration = 0.4;
    popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    
    [self.layer addAnimation:popAnimation forKey:nil];
}

@end
