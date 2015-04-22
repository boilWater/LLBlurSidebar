//
//  NoteViewController.m
//  Calendar
//
//  Created by Jack on 15/4/12.
//  Copyright (c) 2015年 张凡. All rights reserved.
//

#import "NoteViewController.h"
#import "CalendarDayModel.h"
#import "ViewController.h"

@interface NoteViewController (){
    CalendarHomeViewController *chvc;
    
}


@end

@implementation NoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *backGround = [UIImage imageNamed:@"notebook_detailbg"];
    [backGround drawInRect:CGRectMake(0, 97, self.view.frame.size.width, self.view.frame.size.height)];
    [_content setBackgroundColor:[UIColor colorWithPatternImage:backGround]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationCenter:) name:@"myNotification" object:nil];
}
- (void)notificationCenter:(NSNotification *) notification{
//    NSLog(@"%@",[[notification object] getWeek]);
}


- (IBAction)ReturnMainViewController:(id)sender {
    ViewController *viewController = [[ViewController alloc] init];
    [viewController setModalPresentationStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:viewController animated:YES completion:nil];
}
- (IBAction)SaveCalenderContent:(id)sender {
    
}
@end
