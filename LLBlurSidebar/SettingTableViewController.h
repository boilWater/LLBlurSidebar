//
//  SettingTableViewController.h
//  四木记事本
//
//  Created by Jack on 15/4/18.
//  Copyright (c) 2015年 Lugede. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
//    NSArray *dataArray;
}

//@property (strong, nonatomic) IBOutlet UITableView *SettingTableView;
@property (weak, nonatomic) NSArray *dataArray;
@end
