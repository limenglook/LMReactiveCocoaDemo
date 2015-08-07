//
//  LMCountDownButton.m
//  LMCountDownButton
//
//  Created by 李蒙 on 15/6/30.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "LMCountDownButton.h"

@interface LMCountDownButton ()
{
    NSTimer *_timer;
    NSDate *_startDate;
    NSInteger _totalSecond;
    NSInteger _remainSecond;
    
    DidChange _didChange;
    DidFinished _didFinished;
}
@end

@implementation LMCountDownButton

- (void)lm_startWithTotalSecond:(NSInteger)totalSecond didChange:(DidChange)didChange didFinished:(DidFinished)didFinished
{
    [self startWithTotalSecond:totalSecond];
    
    _didChange = didChange;
    _didFinished = didFinished;
}

- (void)startWithTotalSecond:(NSInteger)totalSecond
{
    _totalSecond = totalSecond;
    _remainSecond = totalSecond;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStart:) userInfo:nil repeats:YES];
    _startDate = [NSDate date];
    
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)timerStart:(NSTimer *)timer
{
    double deltaTime = [[NSDate date] timeIntervalSinceDate:_startDate];
    _remainSecond = _totalSecond - (NSInteger)(deltaTime + 1);
    
    if (_remainSecond <= 0) {
        
        [self lm_stopTimer];
        
    } else {
        
        [self change];
    }
}

- (void)change
{
    self.enabled = NO;
    
    if (_didChange) {
        
        [self setTitle:_didChange(self, _remainSecond) forState:UIControlStateNormal];
        [self setTitle:_didChange(self, _remainSecond) forState:UIControlStateDisabled];
        
    } else {
        
        NSString *title = [NSString stringWithFormat:@"%zd秒", _remainSecond];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitle:title forState:UIControlStateDisabled];
    }
}

- (void)lm_stopTimer
{
    self.enabled = YES;
    
    if (_timer) {
        
        if ([_timer respondsToSelector:@selector(isValid)]) {
            
            if ([_timer isValid]) {
                
                [_timer invalidate];
                
                _remainSecond = _totalSecond;
                
                if (_didFinished) {
                    
                    [self setTitle:_didFinished(self,_totalSecond) forState:UIControlStateNormal];
                    [self setTitle:_didFinished(self,_totalSecond) forState:UIControlStateDisabled];
                    
                } else {
                    
                    [self setTitle:@"重新获取" forState:UIControlStateNormal];
                    [self setTitle:@"重新获取" forState:UIControlStateDisabled];
                }
            }
        }
    }
}

@end
