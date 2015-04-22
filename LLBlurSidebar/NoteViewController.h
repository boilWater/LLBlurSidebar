//
//  NoteViewController.h
//  Calendar
//
//  Created by Jack on 15/4/12.
//  Copyright (c) 2015年 张凡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarHomeViewController.h"
@interface NoteViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *content;

- (IBAction)ReturnMainViewController:(id)sender;
//@property (weak, nonatomic) IBOutlet UIBarButtonItem *SaveCalenderContent;

- (IBAction)SaveCalenderContent:(id)sender;
@end
