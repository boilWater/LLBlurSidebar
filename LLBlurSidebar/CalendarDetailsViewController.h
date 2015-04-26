//
//  CalendarDetailsViewController.h
//  四木记事本
//
//  Created by Jack on 15/4/24.
//  Copyright (c) 2015年 Lugede. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarDetailsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView *noteTableView;
}


@property (nonatomic)  NSMutableArray *canlendarContentArray;
@property (nonatomic)  NSMutableArray *canlendarTitleArray;
@property (nonatomic)  NSMutableArray *canlendarDateArray;

@property (weak, nonatomic) IBOutlet UITableView *mainUITableView;
@end
