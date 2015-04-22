//
//  AppDelegate.h
//  LLBlurSidebar
//
//  Created by Lugede on 14/11/20.
//  Copyright (c) 2014年 lugede.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@class ViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    sqlite3 *db;
    sqlite3_stmt *stmt;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;

@end

