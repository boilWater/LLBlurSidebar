//
//  CalendarDetailsViewController.m
//  四木记事本
//
//  Created by Jack on 15/4/24.
//  Copyright (c) 2015年 Lugede. All rights reserved.
//

#import "CalendarDetailsViewController.h"
#import "MainCell.h"
#import "DetailsViewController.h"

@interface CalendarDetailsViewController (){

}
@property NSMutableArray *filteredNoteArray;
@end

@implementation CalendarDetailsViewController
@synthesize mainUITableView,filteredNoteArray,canlendarContentArray,canlendarDateArray,canlendarTitleArray;


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.canlendarDateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"calendar_time"];
    self.canlendarTitleArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"calendar_title"];
    self.canlendarContentArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"calendar_content"];
    
    [self.mainUITableView reloadData]; // to reload selected cell
    NSLog(@"%@,%@,%@",[self.canlendarDateArray objectAtIndex:0],[self.canlendarTitleArray objectAtIndex:0],[self.canlendarContentArray objectAtIndex:0]);//可以显示数据
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, width, height) style:UITableViewStylePlain];
    NSLog(@"%f,%f",width,height);
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    self.mainUITableView = tableView;
    [self.view addSubview:mainUITableView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [filteredNoteArray count];
    }
    else return [self.canlendarContentArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s","我是好人！");
    static NSString *CellIdentifier = @"MainCellID";
    MainCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell==nil) {
        cell = [[MainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    NSString *note;
    NSString *title;
    if (tableView == self.mainUITableView) {
        note = [canlendarContentArray objectAtIndex:indexPath.row];
        title = [canlendarTitleArray objectAtIndex:indexPath.row];
    }
    NSString *date = [canlendarDateArray objectAtIndex:indexPath.row];
    NSUInteger charNum = [note length];
    if (charNum < 22) {
        cell.noteContent.text = note;
    }else {
        cell.noteContent.text =[[note substringToIndex:18] stringByAppendingString:@"......"];
    }
    cell.noteTitle.text = title;
    cell.noteDate.text = date;
    
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //    NSString *note  = nil;
    //    if (tableView == self.searchDisplayController.searchResultsTableView) {
    //        note = [filteredNoteArray objectAtIndex:indexPath.row];
    //    }
    //    //修改
    //    else
    //        if(tableView == self.mainUITableView){
    //        note = [noteArray objectAtIndex:indexPath.row];
    //    };
    //    NSString *date = [dateArray objectAtIndex:indexPath.row];
    //    NSUInteger charnum = [note length];
    //    if (charnum < 22) {
    //        cell.textLabel.text = note;
    //        NSLog(@"%@",note);
    //    }
    //    else{
    //        //显示每个cell的内容
    //        cell.textLabel.text = [[note substringToIndex:18] stringByAppendingString:@"..."];
    //    }
    //    cell.detailTextLabel.text = date;
    //    cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
    return cell;
}

#pragma 点击关于主页的日记就进入相应（展示细节的界面）
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailsViewController *modifyCtrl = [[DetailsViewController alloc]initWithNibName:nil bundle:nil];
    [modifyCtrl setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:modifyCtrl animated:YES completion:nil];
    NSInteger row = [indexPath row];
    modifyCtrl.index = row;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

@end
