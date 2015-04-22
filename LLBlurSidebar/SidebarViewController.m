//
//  SidebarViewController.m
//  LLBlurSidebar
//
//  Created by Lugede on 14/11/20.
//  Copyright (c) 2014年 lugede.cn. All rights reserved.
//

#import "SidebarViewController.h"
#import "ViewController.h"
#import "NoteBookController.h"
#import "CalendarHomeViewController.h"
#import "CalendarViewController.h"
#import "Color.h"
#import "SetViewController.h"

@interface SidebarViewController (){
    
    CalendarHomeViewController *chvc;

}

@end

@implementation SidebarViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    CGFloat h = self.view.frame.size.height/7;
    CGFloat w = self.view.frame.size.width/2;
   
     NSLog(@"height = %f,whight = %f", h, w);
    
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    //关于日记本的按钮设置
    UIButton *noteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [noteButton setBackgroundColor:[UIColor clearColor]];
    [noteButton setFrame:CGRectMake(0, h*2, w, h/2)];
    [noteButton setTag:1];
    [noteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [noteButton setTitle:@"记事本" forState:UIControlStateNormal];
    [noteButton.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [self.view addSubview:noteButton];
    [noteButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //关于日历的按钮设置
    UIButton *calendarButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [calendarButton setBackgroundColor:[UIColor clearColor]];
    [calendarButton setFrame:CGRectMake(0, h*4, w, h/2)];
    [calendarButton setTag:2];
    [calendarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [calendarButton setTitle:@"日历" forState:UIControlStateNormal];
    [calendarButton.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [self.view addSubview:calendarButton];
    [calendarButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //关于设置按钮的设置
    UIButton *setButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [setButton setBackgroundColor:[UIColor clearColor]];
    [setButton setFrame:CGRectMake(w/2, h*6, h/2, h/2)];
    [setButton setBackgroundImage:[UIImage imageNamed:@"note_object_shape_normal"] forState:UIControlStateNormal];
    [setButton setBackgroundImage:[UIImage imageNamed:@"note_object_shape_focus"]forState:UIControlStateSelected];
    [setButton setTag:3];
    [setButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [setButton setTitle:@"设置" forState:UIControlStateNormal];
    [setButton.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [self.view addSubview:setButton];
    [setButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
     
}
-(void)onClick:(id)sender{
     switch ([sender tag]) {
         case 1:
         {
             NSLog(@"点击记事本按钮！");
             //            [NSThread detachNewThreadSelector:@selector(gotoNoteBookController) toTarget:self withObject:nil];
             NoteBookController *noteBookController = [[NoteBookController alloc] init];
             [self presentViewController:noteBookController animated:YES completion:nil];
             break;
         }
             
         case 2:
         {
             NSLog(@"点击日历按钮！");
             CalendarHomeViewController *calendarBookController = [[CalendarHomeViewController alloc] init];
             [self presentViewController:calendarBookController animated:YES completion:nil];
             
             break;
         }
         case 3:
         {
             NSLog(@"点击shizhi按钮！");
             SetViewController *settingController = [[SetViewController alloc] init];
             [self presentViewController:settingController animated:YES completion:nil];
             
             break;
         }
         default:
             break;
     }
}
-(void)click:(UIButton *)but
{
    
    if (!chvc) {
        
        chvc = [[CalendarHomeViewController alloc]init];
        
        chvc.calendartitle = @"飞机";
        
        [chvc setAirPlaneToDay:365 ToDateforString:nil];//飞机初始化方法
        
    }
    
    chvc.calendarblock = ^(CalendarDayModel *model){
//
//        NSLog(@"\n---------------------------");
//        NSLog(@"1星期 %@",[model getWeek]);
//        NSLog(@"2字符串 %@",[model toString]);
//        NSLog(@"3节日  %@",model.holiday);
//        
//        if (model.holiday) {
//            
//            [but setTitle:[NSString stringWithFormat:@"%@ %@ %@",[model toString],[model getWeek],model.holiday] forState:UIControlStateNormal];
//            
//        }else{
//            
//            [but setTitle:[NSString stringWithFormat:@"%@ %@",[model toString],[model getWeek]] forState:UIControlStateNormal];
//            
//        }
    };
    [chvc setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:chvc animated:YES completion:nil];
    
}



@end
