//
//  UITextView+LM.m
//  LMCategory
//
//  Created by 李蒙 on 15/7/9.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "UITextView+LM.h"
#import <objc/runtime.h>

@interface UITextView ()

@property(strong, nonatomic) UITextView *placeholderTextView;

@end

static char placeholderTextViewKey;

@implementation UITextView (LM)

- (void)setPlaceholderTextView:(UITextView *)placeholderTextView {
    
    objc_setAssociatedObject(self, &placeholderTextViewKey, placeholderTextView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UITextView *)placeholderTextView {
    
    return objc_getAssociatedObject(self, &placeholderTextViewKey);
}

#pragma mark 占位提示

- (void)lm_placeholder:(NSString *)lm_placeholder {
    
    if (![self placeholderTextView]) {
        
        UITextView *textView = [[UITextView alloc] initWithFrame:self.bounds];
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = [UIColor grayColor];
        textView.userInteractionEnabled = NO;
        [self addSubview:textView];
        
        [self setPlaceholderTextView:textView];
        
        NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
        
        [[NSNotificationCenter defaultCenter] addObserverForName:UITextViewTextDidChangeNotification object:nil queue:mainQuene usingBlock:^(NSNotification *note) {
            
            textView.hidden = self.text.length;
        }];
    }
    
    self.placeholderTextView.font = self.font;
    self.placeholderTextView.text = lm_placeholder;
}

#pragma mark 限制输入长度

- (void)lm_limitLength:(NSUInteger)length
{
    NSOperationQueue *mainQuene = [NSOperationQueue mainQueue];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UITextViewTextDidChangeNotification object:nil queue:mainQuene usingBlock:^(NSNotification *note) {
        
        if (self.text.length > length && !self.markedTextRange) {
            
            self.text = [self.text substringWithRange: NSMakeRange(0, length)];
        }
    }];
}

@end
