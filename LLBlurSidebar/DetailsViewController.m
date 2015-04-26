//
//  DetailsViewController.m
//  四木记事本
//
//  Created by Jack on 15/4/24.
//  Copyright (c) 2015年 Lugede. All rights reserved.
//

#import "DetailsViewController.h"
#import "CalendarDetailsViewController.h"
@interface DetailsViewController ()<UIAlertViewDelegate>

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *timeArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"calendar_time"];
    NSString *canlendarDate = [timeArray objectAtIndex:self.index];
    _canlendarDetailDate.text = canlendarDate;
    
    NSArray *titleArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"calendar_title"];
    NSString *canlendarTitle = [titleArray objectAtIndex:self.index];
    _canlendarDetailTitle.text = canlendarTitle;
    
    NSArray *contentArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"calendar_content"];
    NSString *canlendarContent = [contentArray objectAtIndex:self.index];
    _canlendarDetailContent.text = canlendarContent;
    UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"simu"]];
    [_canlendarDetailContent setBackgroundColor:color];
}

- (IBAction)canlendarDetailOutDeleteAndSave:(UISegmentedControl *)sender {
    switch ([sender selectedSegmentIndex]) {
        case 0:
        {
            NSLog(@"导出!");
            break;
        }
        case 1:
        {
            NSLog(@"删除!");
            [self deleteCanlendar];
            break;
        }
        case 2:
        {
            NSLog(@"保存!");
            break;
        }
        default:
            break;
    }
}

#pragma 保存修改数据
- (void)saveCanlendar{
    
    NSArray *tempContent = [[NSUserDefaults standardUserDefaults] objectForKey:@"calendar_content"];
    NSMutableArray *mutableContent = [tempContent mutableCopy];
    [mutableContent removeObjectAtIndex:self.index];
    [mutableContent insertObject:[_canlendarDetailContent text] atIndex:0];
    CalendarDetailsViewController *rootctrl = [[CalendarDetailsViewController alloc]init];
    rootctrl.canlendarContentArray = mutableContent;
    [[NSUserDefaults standardUserDefaults] setObject:mutableContent forKey:@"calendar_content"];
    
    NSArray *tempTitle = [[NSUserDefaults standardUserDefaults] objectForKey:@"calendar_title"];
    NSMutableArray *mutableTitle = [tempTitle mutableCopy];
    [mutableTitle removeObjectAtIndex:self.index];
    [mutableTitle insertObject:[_canlendarDetailTitle text] atIndex:0];
//    CalendarDetailsViewController *rootctrl = [[CalendarDetailsViewController alloc]init];
    rootctrl.canlendarTitleArray = mutableTitle;
    [[NSUserDefaults standardUserDefaults] setObject:mutableTitle forKey:@"calendar_title"];
    
    NSArray *tempTime = [[NSUserDefaults standardUserDefaults] objectForKey:@"calendar_time"];
    NSMutableArray *mutableTime = [tempTime mutableCopy];
    [mutableTime removeObjectAtIndex:self.index];
    [mutableTime insertObject:[_canlendarDetailDate text] atIndex:0];
    //    CalendarDetailsViewController *rootctrl = [[CalendarDetailsViewController alloc]init];
    rootctrl.canlendarDateArray = mutableTime;
    [[NSUserDefaults standardUserDefaults] setObject:mutableTime forKey:@"calendar_time"];
    
    [_canlendarDetailContent resignFirstResponder];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"save success!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alertView show];
}

#pragma 删除数据
- (void)deleteCanlendar{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"Are you sure to delete this note?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [alertView show];
}

#pragma 返回首界面
- (IBAction)canlendarReturn:(id)sender {
    ViewController *viewController = [[ViewController alloc] init];
    [viewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        NSArray *tempArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"calendar_content"];
        NSMutableArray *mutableArray = [tempArray mutableCopy];
        [mutableArray removeObjectAtIndex:self.index];
        [[NSUserDefaults standardUserDefaults] setObject:mutableArray forKey:@"calendar_content"];
        CalendarDetailsViewController *rootctrl = [[CalendarDetailsViewController alloc]init];
        rootctrl.canlendarContentArray = mutableArray;
        
        NSArray *tempDateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"calendar_time"];
        NSMutableArray *mutableDateArray = [tempDateArray mutableCopy];
        [mutableDateArray removeObjectAtIndex:self.index];
        [[NSUserDefaults standardUserDefaults] setObject:mutableDateArray forKey:@"calendar_time"];
        rootctrl.canlendarDateArray = mutableDateArray;
        
        NSArray *tempTitleArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"calendar_title"];
        NSMutableArray *mutableTitleArray = [tempTitleArray mutableCopy];
        [mutableTitleArray removeObjectAtIndex:self.index];
        [[NSUserDefaults standardUserDefaults] setObject:mutableDateArray forKey:@"calendar_title"];
        rootctrl.canlendarTitleArray = mutableDateArray;

        
        ViewController *viewController = [[ViewController alloc] init];
        [viewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self presentViewController:viewController animated:YES completion:nil];
    }
    else if (buttonIndex == 1) return;
}


@end
