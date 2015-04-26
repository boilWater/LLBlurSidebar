//
//  NoteCalendarController.m
//  四木记事本
//
//  Created by Jack on 15/4/24.
//  Copyright (c) 2015年 Lugede. All rights reserved.
//

#import "NoteCalendarController.h"
#import "ViewController.h"
#import "CalendarDetailsViewController.h"


@interface NoteCalendarController (){
    CGFloat buttonTag;
    NSString *firstDate;
    NSString *secondDate;
    
}

@property (nonatomic, strong) NSDate *selectedDate;

@end

@implementation NoteCalendarController
@synthesize startDateCanlendar,endDateCanlendar;
//@synthesize titleCanlendar,contentCanlendar;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
//    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, width, height) style:UITableViewStylePlain];
    NSLog(@"%f,%f",width,height);
    UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"simu"]];
    [_contentCanlendar setBackgroundColor:color];
   
}


- (IBAction)returnCalendarViewController:(id)sender {
    ViewController *viewcontroller = [[ViewController alloc] init];
    [viewcontroller setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:viewcontroller animated:YES completion:nil];
}

- (IBAction)saveCalendarViewController:(id)sender {
}

- (IBAction)detailAndSaveSegmentedControl:(UISegmentedControl *)sender {
    switch ([sender selectedSegmentIndex]) {
        case 0:
        {
            CalendarDetailsViewController *calendarDetailsViewController = [[CalendarDetailsViewController alloc] init];
            [calendarDetailsViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            [self presentViewController:calendarDetailsViewController animated:YES completion:nil];
//            NSLog(@"xiangqing");
            break;
        }
        case 1:
        {
//            [self saveCalendarContent:firstDate secondDate:secondDate];
            [self saveCalendarContent:firstDate secondDate:secondDate title:[_titleCanlendar text] content:[_contentCanlendar text]];
            NSLog(@"%@,%@",[_titleCanlendar text],[_contentCanlendar text]);
//            NSLog(@"保存！");
            break;
        }
        default:
            break;
    }
}

#pragma 事情开始时间
- (IBAction)startDateCanlendar:(id)sender {
//    startDateCanlendar.enabled = NO;
    buttonTag = 1;
    HSDatePickerViewController *hsdpvc = [HSDatePickerViewController new];
    hsdpvc.delegate = self;
    if (self.selectedDate) {
        hsdpvc.date = self.selectedDate;
    }
    [self presentViewController:hsdpvc animated:YES completion:nil];
}

#pragma 事情结束时间
- (IBAction)endDateCanlendar:(id)sender {
    buttonTag = 2;
    HSDatePickerViewController *hsdpvc = [HSDatePickerViewController new];
    hsdpvc.delegate = self;
    if (self.selectedDate) {
        hsdpvc.date = self.selectedDate;
    }
    [self presentViewController:hsdpvc animated:YES completion:nil];
}
/*
 *保存calendar的具体数据进入数据库
 *
 *
 */
- (void)saveCalendarContent:(NSString *)first secondDate:(NSString *)second title:(NSString *) canlendarTitle content:(NSString *)canlendarContent {
    if (first == nil) {
        first = @"";
    }
    if (second == nil) {
        second = @"";
    }
    NSString *canlendarDate = [first stringByAppendingFormat:[@"~" stringByAppendingFormat:second]];
    NSLog(@"%@", canlendarDate);
    //添加日期到Array
    NSMutableArray *initTimeQuantum = [[NSMutableArray alloc] init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"calendar_time"] == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:initTimeQuantum forKey:@"calendar_time"];
    }
    NSArray *timeArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"calendar_time"];
    NSMutableArray *mutableDateArray = [timeArray mutableCopy];
    [mutableDateArray insertObject:canlendarDate atIndex:0];
    
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
    NSString *textstring3 = canlendarTitle;
    NSLog(@"%@",canlendarTitle);
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
    NSString *textstring = canlendarContent;
    NSLog(@"%@",canlendarContent);
    [mutableNoteArray insertObject:textstring atIndex:0 ];
    CalendarDetailsViewController *calendarDetailsViewController2 = [[CalendarDetailsViewController alloc] init];
    calendarDetailsViewController2.canlendarContentArray = mutableTitleNoteArray;
    [[NSUserDefaults standardUserDefaults] setObject:mutableNoteArray forKey:@"calendar_content"];
    
    [_contentCanlendar resignFirstResponder];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"add success!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alertView show];
    
}
#pragma mark - HSDatePickerViewControllerDelegate
- (void)hsDatePickerPickedDate:(NSDate *)date {
    NSLog(@"Date picked %@", date);
    NSDateFormatter *dateFormater = [NSDateFormatter new];
    dateFormater.dateFormat = @"yyyy.MM.dd ";
    NSLog(@"%@", [dateFormater stringFromDate:date]);
//    self.dateLabel.text = [dateFormater stringFromDate:date];
//    self.startDateCanlendar.titleLabel.text = [dateFormater stringFromDate:date];
//    self.endDateCanlendar.titleLabel.text = [dateFormater stringFromDate:date];
    NSString *stringDate = [dateFormater stringFromDate:date];
    if (buttonTag == 1) {
        [startDateCanlendar setTitle:stringDate forState:UIControlStateNormal];
        firstDate = stringDate;
    }
    if (buttonTag == 2) {
        [endDateCanlendar setTitle:stringDate forState:UIControlStateNormal];
        secondDate = stringDate;
    }
    
    
    self.selectedDate = date;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        
    }
}

//optional
- (void)hsDatePickerDidDismissWithQuitMethod:(HSDatePickerQuitMethod)method {
    NSLog(@"Picker did dismiss with %lu", method);
}

//optional
- (void)hsDatePickerWillDismissWithQuitMethod:(HSDatePickerQuitMethod)method {
    NSLog(@"Picker will dismiss with %lu", method);
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return NO;
}
@end
