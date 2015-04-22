//
//  NoteBookController.m
//  四木记事本
//
//  Created by Jack on 15-4-10.
//  Copyright (c) 2015年 chen. All rights reserved.
//

#import "NoteBookController.h"
#import "ViewController.h"

@interface NoteBookController(){
//    UIImageView *backGround;
}

@end

@implementation NoteBookController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    backGround = [[UIImageView alloc] init];
//    backGround.image = [UIImage imageNamed:@"bg_drawing_02"];
//    backGround.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    [self.view addSubview:backGround];
    UIImage *backGround = [UIImage imageNamed:@"notebook_detailbg"];
    [backGround drawInRect:CGRectMake(0, 97, self.view.frame.size.width, self.view.frame.size.height)];
    [_noteContent setBackgroundColor:[UIColor colorWithPatternImage:backGround]];
//    _backGround.image = [UIImage imageNamed:@"bg_notebook_08"];
}

- (IBAction)saveNote:(UIBarButtonItem *)sender {
    NSMutableArray *initNoteArray = [[NSMutableArray alloc]init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"note"]==nil) {
        [[NSUserDefaults standardUserDefaults] setObject:initNoteArray forKey:@"note"];
    }
    NSArray *tempNoteArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"note"];
    NSMutableArray *mutableNoteArray = [tempNoteArray mutableCopy];
    NSString *textstring = [_noteContent text];
    [mutableNoteArray insertObject:textstring atIndex:0 ];
    ViewController *rootctrl = [[ViewController alloc]init];
    rootctrl.noteArray = mutableNoteArray;
    [[NSUserDefaults standardUserDefaults] setObject:mutableNoteArray forKey:@"note"];
    
//添加标题
    NSMutableArray *initTitleArray = [[NSMutableArray alloc] init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"title"] == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:initTitleArray forKey:@"title"];
    }
    NSArray *tempTitleArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"title"];
    NSMutableArray *mutableTitleNoteArray = [tempNoteArray mutableCopy];
    NSString *textstring3 = [_noteTitle text];
    [mutableTitleNoteArray insertObject:textstring3 atIndex:0 ];
    ViewController *rootctrl2 = [[ViewController alloc]init];
    rootctrl2.titleArray = mutableTitleNoteArray;
    [[NSUserDefaults standardUserDefaults] setObject:mutableTitleNoteArray forKey:@"title"];
    
//    NSLog(@"%@", [rootctrl.noteArray objectAtIndex:0]);
    
    NSMutableArray *initDateArray = [[NSMutableArray alloc]init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"date"]==nil) {
        [[NSUserDefaults standardUserDefaults] setObject:initDateArray forKey:@"date"];
    }
    NSArray *tempDateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
    NSMutableArray *mutableDateArray = [tempDateArray mutableCopy];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init ];
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    NSDate *now = [NSDate date];
    NSString *datestring = [dateFormatter stringFromDate:now];
    [mutableDateArray insertObject:datestring atIndex:0 ];
    rootctrl.dateArray = mutableDateArray;
    [[NSUserDefaults standardUserDefaults] setObject:mutableDateArray forKey:@"date"];
    
    
    [_noteContent resignFirstResponder];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"add success!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alertView show];

}

//返回主界面
- (IBAction)returnMain:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
//    ViewController *viewController = [[ViewController alloc] init];
//    [viewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
//    [self presentViewController:viewController animated:YES completion:nil];
    
}
@end
