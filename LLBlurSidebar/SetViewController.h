//
//  SetViewController.h
//  四木记事本
//
//  Created by Jack on 15/4/18.
//  Copyright (c) 2015年 Lugede. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PAPasscodeViewController.h"
@interface SetViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,PAPasscodeViewControllerDelegate>

@property (weak, nonatomic) NSArray *dataArray;
- (IBAction)ReturnSetting:(UIBarButtonItem *)sender;

@end
