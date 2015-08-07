//
//  LoginDemoTC.m
//  LMReactiveCocoaDemo
//
//  Created by 李蒙 on 15/8/7.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "LoginDemoTC.h"
#import <ReactiveCocoa.h>
#import <LMKit.h>

@interface LoginDemoTC ()

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginDemoTC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self lm_tapDismissKeyboard];
    
    RAC(self.loginButton, enabled) = [RACSignal combineLatest:@[self.userNameTextField.rac_textSignal, self.passwordTextField.rac_textSignal] reduce:^(NSString *userName, NSString *password) {
        
        return @(userName.length && password.length);
    }];
    
    @weakify(self)
    
    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *button) {
        
        @strongify(self)
        
        [self.view endEditing:YES];
        
        LMAlertShow(@"Welcome");
    }];
}

@end
