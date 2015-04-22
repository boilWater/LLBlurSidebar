//
//  SetPassWordViewController.m
//  四木记事本
//
//  Created by Jack on 15/4/18.
//  Copyright (c) 2015年 Lugede. All rights reserved.
//

#import "SetPassWordViewController.h"
//#import "PAPasscodeViewController.h"

@interface SetPassWordViewController ()

@end

@implementation SetPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

#pragma 返回设置的主页
- (IBAction)RuturnSetController:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma 确定密码设置
- (IBAction)setPassWord:(UIBarButtonItem *)sender {
    PAPasscodeViewController *passcodeViewController = [[PAPasscodeViewController alloc] initForAction:PasscodeActionSet];
    passcodeViewController.delegate = self;
//    passcodeViewController.simple = _simpleSwitch.on;
    [self presentViewController:passcodeViewController animated:YES completion:nil];

}
#pragma mark - PAPasscodeViewControllerDelegate

- (void)PAPasscodeViewControllerDidCancel:(PAPasscodeViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)PAPasscodeViewControllerDidEnterPasscode:(PAPasscodeViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:^() {
        [[[UIAlertView alloc] initWithTitle:nil message:@"Passcode entered correctly" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];
}

- (void)PAPasscodeViewControllerDidSetPasscode:(PAPasscodeViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:^() {
//        _passcodeLabel.text = controller.passcode;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"设定密码" message:@"设定成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
    }];
}

- (void)PAPasscodeViewControllerDidChangePasscode:(PAPasscodeViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:^() {
//        _passcodeLabel.text = controller.passcode;
    }];
}

- (void)viewDidUnload {
//    [self setSimpleSwitch:nil];
    [super viewDidUnload];
}

@end
