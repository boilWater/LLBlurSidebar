//
//  PAPasscodeViewController.h
//  PAPasscode
//
//  Created by Denis Hennessy on 15/10/2012.
//  Copyright (c) 2012 Peer Assembly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

typedef enum {
    PasscodeActionSet,
    PasscodeActionEnter,
    PasscodeActionChange
} PasscodeAction;

@class PAPasscodeViewController;

@protocol PAPasscodeViewControllerDelegate <NSObject>

- (void)PAPasscodeViewControllerDidCancel:(PAPasscodeViewController *)controller;

@optional

- (void)PAPasscodeViewControllerDidChangePasscode:(PAPasscodeViewController *)controller;
- (void)PAPasscodeViewControllerDidEnterPasscode:(PAPasscodeViewController *)controller;
- (void)PAPasscodeViewControllerDidSetPasscode:(PAPasscodeViewController *)controller;
- (void)PAPasscodeViewController:(PAPasscodeViewController *)controller didFailToEnterPasscode:(NSInteger)attempts;

@end

@interface PAPasscodeViewController : UIViewController {
    UIView *contentView;
    NSInteger phase;
    UILabel *promptLabel;
    UILabel *messageLabel;
    UIImageView *failedImageView;
    UILabel *failedAttemptsLabel;
    UITextField *passcodeTextField;
    UIImageView *digitImageViews[4];
    UIImageView *snapshotImageView;
    
    //初始化数据库
//    sqlite3 *db;
//    sqlite3_stmt *stmt;

    sqlite3 *db;
    sqlite3_stmt *stmt;
    
}

@property (readonly) PasscodeAction action;
@property (weak) id<PAPasscodeViewControllerDelegate> delegate;
@property (strong) NSString *passcode;
@property (assign) BOOL simple;
@property (assign) NSInteger failedAttempts;
@property (strong) NSString *enterPrompt;
@property (strong) NSString *confirmPrompt;
@property (strong) NSString *changePrompt;
@property (strong) NSString *message;

- (id)initForAction:(PasscodeAction)action;

@end
