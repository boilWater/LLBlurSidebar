//
//  TodayViewController.h
//  四木记事本
//
//  Created by Jack on 15/4/29.
//  Copyright (c) 2015年 Lugede. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodayViewController : UIViewController

- (IBAction)returnMainLayout:(id)sender;
- (IBAction)dateAndSaveUISegmentControl:(UISegmentedControl *)sender;


@property (weak, nonatomic) IBOutlet UITextField *dateUITextField;
@property (weak, nonatomic) IBOutlet UITextField *titleUITextFeild;

@property (weak, nonatomic) IBOutlet UITextView *contentUITextView;
@end
