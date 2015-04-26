//
//  DetailsViewController.h
//  四木记事本
//
//  Created by Jack on 15/4/24.
//  Copyright (c) 2015年 Lugede. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface DetailsViewController : UIViewController

@property NSInteger index;

@property (weak, nonatomic) IBOutlet UITextField *canlendarDetailDate;
@property (weak, nonatomic) IBOutlet UITextField *canlendarDetailTitle;
@property (weak, nonatomic) IBOutlet UITextView *canlendarDetailContent;

- (IBAction)canlendarDetailOutDeleteAndSave:(UISegmentedControl *)sender;
- (IBAction)canlendarReturn:(id)sender;
@end
