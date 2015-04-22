//
//  LanchPassWordViewController.m
//  四木记事本
//
//  Created by Jack on 15/4/19.
//  Copyright (c) 2015年 Lugede. All rights reserved.
//

#import "LanchPassWordViewController.h"
#import "ViewController.h"

@interface LanchPassWordViewController ()

@end

@implementation LanchPassWordViewController
@synthesize EnterPassWord;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    EnterPassWord.keyboardType = UIKeyboardTypeNumberPad;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShowOnDelay:) name:UIKeyboardWillShowNotification object:nil];
}

- (IBAction)EnteViewController:(id)sender {
    ViewController *viewController = [[ViewController alloc] init];
    [viewController setModalPresentationStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:viewController animated:YES completion:nil];
    
}
- (void)keyboardWillShowOnDelay:(NSNotification *)notification
{
    [self performSelector:@selector(keyboardWillShow:) withObject:nil afterDelay:0];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    UIButton *doneButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 163, 106, 53)];
    [doneButton setTitle:@"" forState:(UIControlStateNormal)];
    [doneButton addTarget:self action:@selector(doneButton:) forControlEvents:UIControlEventTouchUpInside];
    UIWindow * tempWindow = [[[UIApplication sharedApplication]windows]objectAtIndex:1];
    UIView * keyBoard = nil;
    NSLog(@"%@",tempWindow);
    for (int i = 0; i < tempWindow.subviews.count; i ++) {
        keyBoard = [tempWindow.subviews objectAtIndex:i];
        
        [keyBoard addSubview:doneButton];
    }
    
}

@end
