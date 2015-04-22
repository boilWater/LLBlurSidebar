//
//  MainCell.h
//  四木记事本
//
//  Created by Jack on 15/4/14.
//  Copyright (c) 2015年 Lugede. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *noteTitle;
@property (weak, nonatomic) IBOutlet UILabel *noteContent;
@property (weak, nonatomic) IBOutlet UILabel *noteDate;

@end
