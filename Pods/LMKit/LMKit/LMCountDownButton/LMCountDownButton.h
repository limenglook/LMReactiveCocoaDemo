//
//  LMCountDownButton.h
//  LMCountDownButton
//
//  Created by 李蒙 on 15/6/30.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LMCountDownButton;

typedef NSString *(^DidChange)(LMCountDownButton *button, NSInteger second);

typedef NSString *(^DidFinished)(LMCountDownButton *button, NSInteger second);

@interface LMCountDownButton : UIButton

- (void)lm_startWithTotalSecond:(NSInteger)totalSecond didChange:(DidChange)didChange didFinished:(DidFinished)didFinished;

- (void)lm_stopTimer;

@end
