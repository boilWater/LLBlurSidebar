//
//  MainCell.m
//  四木记事本
//
//  Created by Jack on 15/4/14.
//  Copyright (c) 2015年 Lugede. All rights reserved.
//自定义的Cell,用于存放笔记的Cell文件

#import "MainCell.h"

@implementation MainCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //cell中的标题
        UILabel *noteTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 17, 74, 22)];
        self.noteTitle = noteTitle;
        [self.contentView addSubview:self.noteTitle];
        
        UILabel *noteDate = [[UILabel alloc] initWithFrame:CGRectMake(15, 37, 74, 22)];
        self.noteDate = noteDate;
        [self.contentView addSubview:self.noteDate];
        
        UILabel *noteContent = [[UILabel alloc] initWithFrame:CGRectMake(97, 16, 243, 33)];
        self.noteContent = noteContent;
        [self.contentView addSubview:self.noteContent];
        
    }
    return self;
}

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
