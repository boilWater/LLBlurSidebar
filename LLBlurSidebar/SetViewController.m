//
//  SetViewController.m
//  四木记事本
//
//  Created by Jack on 15/4/18.
//  Copyright (c) 2015年 Lugede. All rights reserved.
//

#import "SetViewController.h"
#import "SetPassWordViewController.h"
#import "SetLOGOAndNameViewController.h"

@interface SetViewController ()

@end

@implementation SetViewController
@synthesize  dataArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *data = [NSArray arrayWithObjects:@"密码设置",@"应用LOGO设置",@"应用名设置", nil];
    
    self.dataArray = data;

}

#pragma mark Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *TableSampleIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleValue2
                reuseIdentifier:TableSampleIdentifier];
    }
//    UILabel
    
    cell.textLabel.text = [self.dataArray objectAtIndex:[indexPath row]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSString *rowString = [self.dataArray objectAtIndex:[indexPath row]];
//    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"选中的行信息" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alter show];
    switch ([indexPath row]) {
        case 0:
        {
            NSLog(@"%@",[self.dataArray objectAtIndex:0]);
            
            PAPasscodeViewController *passcodeViewController = [[PAPasscodeViewController alloc] initForAction:PasscodeActionSet];
            passcodeViewController.delegate = self;
            //    passcodeViewController.simple = _simpleSwitch.on;
            [self presentViewController:passcodeViewController animated:YES completion:nil];
            
            
            break;
        }
        case 1:
        {
            NSLog(@"%@",[self.dataArray objectAtIndex:1]);
            SetLOGOAndNameViewController *setLOGOAndNameViewController = [[SetLOGOAndNameViewController alloc] init];
            [setLOGOAndNameViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            [self presentViewController:setLOGOAndNameViewController animated:YES completion:nil];
            break;
        } case 2:
        {
            NSLog(@"%@",[self.dataArray objectAtIndex:2]);
            break;
        }
    }
}

#pragma mark - PAPasscodeViewControllerDelegate

- (void)PAPasscodeViewControllerDidCancel:(PAPasscodeViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)PAPasscodeViewControllerDidEnterPasscode:(PAPasscodeViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:^() {
        [[[UIAlertView alloc] initWithTitle:nil message:@"Passcode entered correctly" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];
}

- (void)PAPasscodeViewControllerDidSetPasscode:(PAPasscodeViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:^() {
        //        _passcodeLabel.text = controller.passcode;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"设定密码" message:@"设定成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
    }];
}

- (void)PAPasscodeViewControllerDidChangePasscode:(PAPasscodeViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:^() {
        //        _passcodeLabel.text = controller.passcode;
    }];
}

- (void)viewDidUnload {
    //    [self setSimpleSwitch:nil];
    [super viewDidUnload];
}


- (IBAction)ReturnSetting:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
