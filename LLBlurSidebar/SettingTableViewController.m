//
//  SettingTableViewController.m
//  四木记事本
//
//  Created by Jack on 15/4/18.
//  Copyright (c) 2015年 Lugede. All rights reserved.
//

#import "SettingTableViewController.h"

@interface SettingTableViewController ()

@end

@implementation SettingTableViewController
//@synthesize SettingTableView;
@synthesize dataArray;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *data = [NSArray arrayWithObjects:@"密码设置",@"应用LOGO设置",@"应用名设置", nil];
    
    self.dataArray = data;
    
//    self.tableView = SettingTableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleValue1
                reuseIdentifier:TableSampleIdentifier];
    }
    
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [self.dataArray objectAtIndex:row];
    UIImage *image = [UIImage imageNamed:@"qq"];
    cell.imageView.image = image;
    UIImage *highLighedImage = [UIImage imageNamed:@"youdao"];
    cell.imageView.highlightedImage = highLighedImage;
    cell.detailTextLabel.text = @"打打打打";
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *rowString = [self.dataArray objectAtIndex:[indexPath row]];
    UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"选中的行信息" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alter show];
}

@end
