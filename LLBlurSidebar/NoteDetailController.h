//
//  NoteDetailController.h
//  四木记事本
//
//  Created by Jack on 15/4/13.
//  Copyright (c) 2015年 Lugede. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteDetailController : UIViewController
@property NSInteger index;
- (IBAction)noteDetailSegmentedControlAddOrDeleta:(UISegmentedControl *)sender;
- (IBAction)noteDetailMainLayout:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *noteDetailContentText;
@property (weak, nonatomic) IBOutlet UITextView *NoteDetailUITextView;

@end
