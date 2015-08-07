//
//  UIViewController+LMPlaceholderView.m
//  LMPlaceholderView
//
//  Created by 李蒙 on 15/6/29.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "UIViewController+LMPlaceholderView.h"
#import "LMPlaceholderView.h"
#import "LMKit.h"
#import <objc/runtime.h>

@interface UIViewController ()

@property (strong, nonatomic) LMPlaceholderView *placeholder;

@property (copy, nonatomic) RefreshBlock refreshBlock;

@end

static char placeholderKey, refreshKey;

@implementation UIViewController (LMPlaceholderView)

- (void)setPlaceholder:(LMPlaceholderView *)placeholder {
    
    objc_setAssociatedObject(self, &placeholderKey, placeholder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (LMPlaceholderView *)placeholder {
    
    return objc_getAssociatedObject(self, &placeholderKey);
}

- (void)setRefreshBlock:(RefreshBlock)refreshBlock {
    
    objc_setAssociatedObject(self, &refreshKey, refreshBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (RefreshBlock)refreshBlock {
    
    return objc_getAssociatedObject(self, &refreshKey);
}

- (void)lm_showPlaceholderInitWithBackgroundColor:(UIColor *)color imageName:(NSString *)imageName andTitle:(NSString *)title andFrame:(CGRect)frame andRefresBlock:(RefreshBlock)block
{
    [self lm_showPlaceholderInitWithImageName:imageName andTitle:title andFrame:frame andRefresBlock:block];
    
    self.placeholder.backgroundColor = color;
}

- (void)lm_showPlaceholderInitWithBackgroundColor:(UIColor *)color imageName:(NSString *)imageName andTitle:(NSString *)title andRefresBlock:(RefreshBlock)block
{
    [self lm_showPlaceholderInitWithImageName:imageName andTitle:title andRefresBlock:block];
    
    self.placeholder.backgroundColor = color;
}

- (void)lm_showPlaceholderInitWithImageName:(NSString *)imageName andTitle:(NSString *)title andRefresBlock:(RefreshBlock)block
{
    [self lm_showPlaceholderInitWithImageName:imageName andTitle:title andFrame:CGRectMake(0, 0, LMScreenWidth, LMScreenHeight) andRefresBlock:block];
}

- (void)lm_showPlaceholderInitWithImageName:(NSString *)imageName andTitle:(NSString *)title andFrame:(CGRect)frame andRefresBlock:(RefreshBlock)block
{
    self.refreshBlock = block;
    
    if (!self.placeholder) {
        
        self.placeholder = [[LMPlaceholderView alloc] initWithFrame:frame];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(refreshAction)];
        [self.placeholder addGestureRecognizer:tap];
        
        [self.view addSubview:self.placeholder];
    }
    
    [self setScrollEnabled:NO];
    
    [self.placeholder lm_showViewWithImageName:imageName andTitle:title];
}

- (void)refreshAction
{
    if (self.refreshBlock) {
        
        [self lm_hidePlaceholder];
        
        self.refreshBlock();
    }
}

- (void)lm_hidePlaceholder
{
    [self.placeholder lm_hide];
    
    [self setScrollEnabled:YES];
}

- (void)setScrollEnabled:(BOOL)enabled
{
    if ([self respondsToSelector:@selector(setTableView:)]) {
        if ([((UITableViewController *)self).tableView respondsToSelector:@selector(setScrollEnabled:)]) {
            
            [((UITableViewController *)self).tableView setScrollEnabled:enabled];
        }
    }
    
    if ([self respondsToSelector:@selector(setCollectionView:)]) {
        if ([((UICollectionViewController *)self).collectionView respondsToSelector:@selector(setScrollEnabled:)]) {
            
            [((UICollectionViewController *)self).collectionView setScrollEnabled:enabled];
        }
    }
}

@end
