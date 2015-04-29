//
//  TodayViewController.m
//  四木记事本
//
//  Created by Jack on 15/4/29.
//  Copyright (c) 2015年 Lugede. All rights reserved.
//

#import "TodayViewController.h"
#import "ViewController.h"
#import "NoteCalendarController.h"
#import "CalendarDetailsViewController.h"

@interface TodayViewController ()<UIAlertViewDelegate>

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init ];
//    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
//    NSDate *now = [NSDate date];
//    NSString *datestring = [dateFormatter stringFromDate:now];
    //获取当天的日期然后添加到时间框
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    NSDate *now = [NSDate date];
    NSString *dateString  = [dateFormatter stringFromDate:now];
    [_dateUITextField setText:dateString];
}

- (IBAction)returnMainLayout:(id)sender {
    ViewController *viewcontroller = [[ViewController alloc] init];
    [viewcontroller setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:viewcontroller animated:YES completion:nil];

}

- (IBAction)dateAndSaveUISegmentControl:(UISegmentedControl *)sender {
    switch ([sender selectedSegmentIndex]) {
        case 0:
        {
            NoteCalendarController *noteCalendarController = [[NoteCalendarController alloc] init];
            [noteCalendarController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            [self presentViewController:noteCalendarController animated:YES completion:nil];
            NSLog(@"点击时段");
            break;
        }
        case 1:
        {
            [self saveContentText:[_dateUITextField text] title:[_titleUITextFeild text] content:[_contentUITextView text]];
            NSLog(@"保存！");
            break;
            
        }
        default:
            break;
    }
}

#pragma 保存文件到日历数组
- (void)saveContentText:(NSString *) dateString title:(NSString *)title content:(NSString *)content{
    //添加日期到Array
    NSMutableArray *initTimeQuantum = [[NSMutableArray alloc] init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"calendar_time"] == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:initTimeQuantum forKey:@"calendar_time"];
    }
    NSArray *timeArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"calendar_time"];
    NSMutableArray *mutableDateArray = [timeArray mutableCopy];
    [mutableDateArray insertObject:dateString atIndex:0];
    
    CalendarDetailsViewController *calendarDetailsViewController = [[CalendarDetailsViewController alloc] init];
    calendarDetailsViewController.canlendarDateArray = mutableDateArray;
    [[NSUserDefaults standardUserDefaults] setObject:mutableDateArray forKey:@"calendar_time"];
    
    //添加标题到数据库
    NSMutableArray *initTitleArray = [[NSMutableArray alloc] init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"calendar_title"] == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:initTitleArray forKey:@"calendar_title"];
    }
    NSArray *tempTitleArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"calendar_title"];
    NSMutableArray *mutableTitleNoteArray = [tempTitleArray mutableCopy];
    NSString *textstring3 = title;
    NSLog(@"%@",title);
    [mutableTitleNoteArray insertObject:textstring3 atIndex:0 ];
    CalendarDetailsViewController *calendarDetailsViewController1 = [[CalendarDetailsViewController alloc] init];
    calendarDetailsViewController1.canlendarTitleArray = mutableTitleNoteArray;
    [[NSUserDefaults standardUserDefaults] setObject:mutableTitleNoteArray forKey:@"calendar_title"];
    
    //添加内容到数据库
    NSMutableArray *initNoteArray = [[NSMutableArray alloc]init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"calendar_content"]==nil) {
        [[NSUserDefaults standardUserDefaults] setObject:initNoteArray forKey:@"calendar_content"];
    }
    NSArray *tempNoteArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"calendar_content"];
    NSMutableArray *mutableNoteArray = [tempNoteArray mutableCopy];
    NSString *textstring = content;
    NSLog(@"%@",content);
    [mutableNoteArray insertObject:textstring atIndex:0 ];
    CalendarDetailsViewController *calendarDetailsViewController2 = [[CalendarDetailsViewController alloc] init];
    calendarDetailsViewController2.canlendarContentArray = mutableTitleNoteArray;
    [[NSUserDefaults standardUserDefaults] setObject:mutableNoteArray forKey:@"calendar_content"];
    
    [_contentUITextView resignFirstResponder];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"add success!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alertView show];

}
@end
