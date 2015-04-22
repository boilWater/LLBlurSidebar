//
//  AppDelegate.m
//  LLBlurSidebar
//
//  Created by Lugede on 14/11/20.
//  Copyright (c) 2014年 lugede.cn. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "LanchPassWordViewController.h"

#define DBNAME @"personInfo2.sqlite"
@interface AppDelegate ()

@end

@implementation AppDelegate

//加载数据库的路径
-(NSString *)dataFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *myDocPath = [paths objectAtIndex:0];
    NSString *fileName = [myDocPath stringByAppendingPathComponent:DBNAME];
    
    NSLog(@"%@", fileName);
    return fileName;
}
-(char *)searchSql:(NSString *)sql{
    NSString *filePath = [self dataFilePath];
    if (sqlite3_open([filePath UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"打开数据库失败！");
    }
    char *name;
    //编译sql的语句
    sql = @"SELECT * FROM PERSOMINFO";
    sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    //    int result = sqlite3_step(stmt);
    while(sqlite3_step(stmt) == SQLITE_ROW){
        
         name  = (char *)sqlite3_column_text(stmt, 1);
        
       //        char *age  = (char *)sqlite3_column_text(stmt, 2);
//        char *adress  = (char *)sqlite3_column_text(stmt, 3);
        
//        NSString *nameUser = [NSString stringWithUTF8String:name];
//        NSString *ageUser = [NSString stringWithUTF8String:age];
//        NSString *adressUser = [NSString stringWithUTF8String:adress];
        
        return name;
//        NSLog(@"------名字：%@,年龄：%@,地址：%@",nameUser,ageUser,adressUser);
        //        result = sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
    sqlite3_close(db);
    return name;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    NSLog(@"%ld",(long)[self searchSql:@"SELECT * FROM PERSOMINFO"]);
//    NSLog(@"name == >%s",[self searchSql:@"SELECT * FROM PERSOMINFO"]);
    char *temp = nil;
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(searchSql:) object:nil];
    temp = [self searchSql:@"SELECT * FROM PERSOMINFO"];
    [thread start];
    NSLog(@"%s",temp);
    
    
    if (temp == nil) {
        self.viewController = [[ViewController alloc] init];
    }else{
        self.viewController = [[LanchPassWordViewController alloc] init];
    }
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
