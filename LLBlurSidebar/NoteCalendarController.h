//
//  NoteCalendarController.h
//  四木记事本
//
//  Created by Jack on 15/4/24.
//  Copyright (c) 2015年 Lugede. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSDatePickerViewController.h"

@interface NoteCalendarController : UIViewController<HSDatePickerViewControllerDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *startDateCanlendar;
//@property (weak, nonatomic) IBOutlet UITextField *startDateCanlendar;
@property (weak, nonatomic) IBOutlet UIButton *endDateCanlendar;
//@property (weak, nonatomic) IBOutlet UITextField *endDateCanlendar;

@property (weak, nonatomic) IBOutlet UITextField *titleCanlendar;
@property (weak, nonatomic) IBOutlet UITextView *contentCanlendar;


- (IBAction)returnCalendarViewController:(id)sender;
- (IBAction)saveCalendarViewController:(id)sender;
- (IBAction)detailAndSaveSegmentedControl:(UISegmentedControl *)sender;

- (IBAction)startDateCanlendar:(id)sender;
- (IBAction)endDateCanlendar:(id)sender;
@end
