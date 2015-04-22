//
//  NoteBookController.h
//  四木记事本
//
//  Created by Jack on 15-4-10.
//  Copyright (c) 2015年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NoteBookController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *noteTitle;
@property (weak, nonatomic) IBOutlet UITextView *noteContent;
@property (weak, nonatomic) IBOutlet UIImageView *backGround;

- (IBAction)saveNote:(UIBarButtonItem *)sender;
- (IBAction)returnMain:(UIBarButtonItem *)sender;

@end
