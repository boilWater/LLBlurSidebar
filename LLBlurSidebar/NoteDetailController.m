//
//  NoteDetailController.m
//  四木记事本
//
//  Created by Jack on 15/4/13.
//  Copyright (c) 2015年 Lugede. All rights reserved.
//

#import "NoteDetailController.h"
#import "ViewController.h"

@interface NoteDetailController ()<UIAlertViewDelegate>

@end

@implementation NoteDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"note"];
    NSString *oldtext = [array objectAtIndex:self.index];
    _noteDetailContentText.text = oldtext;
    UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"notebook_detailbg"]];
    [_NoteDetailUITextView setBackgroundColor:color];
}

- (IBAction)noteDetailSegmentedControlAddOrDeleta:(UISegmentedControl *)sender {
    switch ([sender selectedSegmentIndex]) {
        case 0:
        {
            NSLog(@"点击删除");
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"Are you sure to delete this note?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
            [alertView show];
            break;
        }
        case 1:
        {
            NSLog(@"点击保存");
            NSArray *tempArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"note"];
            NSMutableArray *mutableArray = [tempArray mutableCopy];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init ];
            [dateFormatter setDateFormat:@"MM-dd HH:mm"];
            NSDate *now = [NSDate date];
            NSString *datestring = [dateFormatter stringFromDate:now];
            NSString *textstring = [_noteDetailContentText text];
            [mutableArray removeObjectAtIndex:self.index];
            [mutableArray insertObject:textstring atIndex:0];
            [[NSUserDefaults standardUserDefaults] setObject:mutableArray forKey:@"note"];
            ViewController *rootctrl = [[ViewController alloc]init];
            rootctrl.noteArray = mutableArray;
            
            NSArray *tempDateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
            NSMutableArray *mutableDateArray = [tempDateArray mutableCopy];
            [mutableDateArray removeObjectAtIndex:self.index];
            [mutableDateArray insertObject:datestring atIndex:0 ];
            rootctrl.dateArray = mutableDateArray;
            [[NSUserDefaults standardUserDefaults] setObject:mutableDateArray forKey:@"date"];
            
            [_noteDetailContentText resignFirstResponder];
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"save success!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alertView show];

            break;
        }
        default:
            break;
    }
}

- (IBAction)noteDetailMainLayout:(id)sender {
    NSLog(@"点击返回");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        NSArray *tempArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"note"];
        NSMutableArray *mutableArray = [tempArray mutableCopy];
        [mutableArray removeObjectAtIndex:self.index];
        [[NSUserDefaults standardUserDefaults] setObject:mutableArray forKey:@"note"];
        ViewController *rootctrl = [[ViewController alloc]init];
        rootctrl.noteArray = mutableArray;
        
        NSArray *tempDateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
        NSMutableArray *mutableDateArray = [tempDateArray mutableCopy];
        [mutableDateArray removeObjectAtIndex:self.index];
        [[NSUserDefaults standardUserDefaults] setObject:mutableDateArray forKey:@"date"];
        rootctrl.dateArray = mutableDateArray;
        
        ViewController *viewController = [[ViewController alloc] init];
        [viewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self presentViewController:viewController animated:YES completion:nil];
    }
    else if (buttonIndex == 1) return;
}

@end
