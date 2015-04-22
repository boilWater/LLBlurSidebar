//
//  ViewController.h
//  LLBlurSidebar
//
//  Created by Lugede on 14/11/20.
//  Copyright (c) 2014年 lugede.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ILBarButtonItem.h"
@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView *noteTableView;
}

//@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (nonatomic)  NSMutableArray *noteArray;
@property (nonatomic)  NSMutableArray *titleArray;
@property (nonatomic)  NSMutableArray *dateArray;

@property (weak, nonatomic) IBOutlet UINavigationBar *topUINavigationBar;

- (IBAction)addNoteBook:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *mainUITableView;

@end

