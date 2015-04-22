//
//  PAPasscodeViewController.m
//  PAPasscode
//
//  Created by Denis Hennessy on 15/10/2012.
//  Copyright (c) 2012 Peer Assembly. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "PAPasscodeViewController.h"

#define NAVBAR_HEIGHT   44
#define PROMPT_HEIGHT   74
#define DIGIT_SPACING   10
#define DIGIT_WIDTH     61
#define DIGIT_HEIGHT    53
#define MARKER_WIDTH    16
#define MARKER_HEIGHT   16
#define MARKER_X        22
#define MARKER_Y        18
#define MESSAGE_HEIGHT  74
#define FAILED_LCAP     19
#define FAILED_RCAP     19
#define FAILED_HEIGHT   26
#define FAILED_MARGIN   10
#define TEXTFIELD_MARGIN 8
#define SLIDE_DURATION  0.3

//数据库的操作
#define DBNAME @"personInfo2.sqlite"
#define NAME @"name"
#define AGE @"age"
#define ADRESS @"adress"

#define TABLENAME @"PERSOMINFO"
#define PASSWORD @"password"
//数据库的操作

@interface PAPasscodeViewController ()
- (void)cancel:(id)sender;
- (void)handleFailedAttempt;
- (void)handleCompleteField;
- (void)passcodeChanged:(id)sender;
- (void)resetFailedAttempts;
- (void)showFailedAttempts;
- (void)showScreenForPhase:(NSInteger)phase animated:(BOOL)animated;
@end

@implementation PAPasscodeViewController

- (id)initForAction:(PasscodeAction)action {
    self = [super init];
    if (self) {
        _action = action;
        switch (action) {
            case PasscodeActionSet:
                self.title = NSLocalizedString(@"Set Passcode", nil);
                _enterPrompt = NSLocalizedString(@"Enter a passcode", nil);
                _confirmPrompt = NSLocalizedString(@"Re-enter your passcode", nil);
                break;
                
            case PasscodeActionEnter:
                self.title = NSLocalizedString(@"Enter Passcode", nil);
                _enterPrompt = NSLocalizedString(@"Enter your passcode", nil);
                break;
                
            case PasscodeActionChange:
                self.title = NSLocalizedString(@"Change Passcode", nil);
                _changePrompt = NSLocalizedString(@"Enter your old passcode", nil);
                _enterPrompt = NSLocalizedString(@"Enter your new passcode", nil);
                _confirmPrompt = NSLocalizedString(@"Re-enter your new passcode", nil);
                break;
        }
        self.modalPresentationStyle = UIModalPresentationFormSheet;
        _simple = YES;
    }
    return self;
}

- (void)loadView {
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;

    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, view.bounds.size.width, NAVBAR_HEIGHT)];
    navigationBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    navigationBar.items = @[self.navigationItem];
    [view addSubview:navigationBar];
    
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, view.bounds.size.width, view.bounds.size.height-NAVBAR_HEIGHT)];
    contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    contentView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [view addSubview:contentView];
    
    CGFloat panelWidth = DIGIT_WIDTH*4+DIGIT_SPACING*3;
    if (!_simple) {
        UIView *digitPanel = [[UIView alloc] initWithFrame:CGRectMake(0, 0, panelWidth, DIGIT_HEIGHT)];
        digitPanel.frame = CGRectOffset(digitPanel.frame, (contentView.bounds.size.width-digitPanel.bounds.size.width)/2, PROMPT_HEIGHT);
        digitPanel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        [contentView addSubview:digitPanel];
        
        UIImage *backgroundImage = [UIImage imageNamed:@"papasscode_background"];
        UIImage *markerImage = [UIImage imageNamed:@"papasscode_marker"];
        CGFloat xLeft = 0;
        for (int i=0;i<4;i++) {
            UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
            backgroundImageView.frame = CGRectOffset(backgroundImageView.frame, xLeft, 0);
            [digitPanel addSubview:backgroundImageView];
            digitImageViews[i] = [[UIImageView alloc] initWithImage:markerImage];
            digitImageViews[i].autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
            digitImageViews[i].frame = CGRectOffset(digitImageViews[i].frame, backgroundImageView.frame.origin.x+MARKER_X, MARKER_Y);
            [digitPanel addSubview:digitImageViews[i]];
            xLeft += DIGIT_SPACING + backgroundImage.size.width;
        }
        passcodeTextField = [[UITextField alloc] initWithFrame:digitPanel.frame];
        passcodeTextField.hidden = YES;
        passcodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    } else {
        UIView *passcodePanel = [[UIView alloc] initWithFrame:CGRectMake(0, 0, panelWidth, DIGIT_HEIGHT)];
        passcodePanel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        passcodePanel.frame = CGRectOffset(passcodePanel.frame, (contentView.bounds.size.width-passcodePanel.bounds.size.width)/2, PROMPT_HEIGHT);
        passcodePanel.frame = CGRectInset(passcodePanel.frame, TEXTFIELD_MARGIN, TEXTFIELD_MARGIN);
        passcodePanel.layer.borderColor = [UIColor colorWithRed:0.65 green:0.67 blue:0.70 alpha:1.0].CGColor;
        passcodePanel.layer.borderWidth = 1.0;
        passcodePanel.layer.cornerRadius = 5.0;
        passcodePanel.layer.shadowColor = [UIColor whiteColor].CGColor;
        passcodePanel.layer.shadowOffset = CGSizeMake(0, 1);
        passcodePanel.layer.shadowOpacity = 1.0;
        passcodePanel.layer.shadowRadius = 1.0;
        passcodePanel.backgroundColor = [UIColor whiteColor];
        [contentView addSubview:passcodePanel];
        passcodeTextField = [[UITextField alloc] initWithFrame:CGRectInset(passcodePanel.frame, 6, 6)];
    }
    passcodeTextField.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    passcodeTextField.borderStyle = UITextBorderStyleNone;
    passcodeTextField.secureTextEntry = YES;
    passcodeTextField.textColor = [UIColor colorWithRed:0.23 green:0.33 blue:0.52 alpha:1.0];
//    passcodeTextField.keyboardType = UIKeyboardTypeNumberPad;
//    passcodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    [passcodeTextField addTarget:self action:@selector(passcodeChanged:) forControlEvents:UIControlEventEditingChanged];
    [contentView addSubview:passcodeTextField];

    promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, contentView.bounds.size.width, PROMPT_HEIGHT)];
    promptLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    promptLabel.backgroundColor = [UIColor clearColor];
    promptLabel.textColor = [UIColor colorWithRed:0.30 green:0.34 blue:0.42 alpha:1.0];
    promptLabel.font = [UIFont boldSystemFontOfSize:17];
    promptLabel.shadowColor = [UIColor whiteColor];
    promptLabel.shadowOffset = CGSizeMake(0, 1);
    promptLabel.textAlignment = UITextAlignmentCenter;
    promptLabel.numberOfLines = 0;
    [contentView addSubview:promptLabel];
    
    messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, PROMPT_HEIGHT+DIGIT_HEIGHT, contentView.bounds.size.width, MESSAGE_HEIGHT)];
    messageLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    messageLabel.backgroundColor = [UIColor clearColor];
    messageLabel.textColor = [UIColor colorWithRed:0.30 green:0.34 blue:0.42 alpha:1.0];
    messageLabel.font = [UIFont systemFontOfSize:14];
    messageLabel.shadowColor = [UIColor whiteColor];
    messageLabel.shadowOffset = CGSizeMake(0, 1);
    messageLabel.textAlignment = UITextAlignmentCenter;
    messageLabel.numberOfLines = 0;
	messageLabel.text = _message;
    [contentView addSubview:messageLabel];
        
    UIImage *failedBg = [[UIImage imageNamed:@"papasscode_failed_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, FAILED_LCAP, 0, FAILED_RCAP)];
    failedImageView = [[UIImageView alloc] initWithImage:failedBg];
    failedImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    failedImageView.hidden = YES;
    [contentView addSubview:failedImageView];
    
    failedAttemptsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    failedAttemptsLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    failedAttemptsLabel.backgroundColor = [UIColor clearColor];
    failedAttemptsLabel.textColor = [UIColor whiteColor];
    failedAttemptsLabel.font = [UIFont boldSystemFontOfSize:15];
    failedAttemptsLabel.shadowColor = [UIColor blackColor];
    failedAttemptsLabel.shadowOffset = CGSizeMake(0, -1);
    failedAttemptsLabel.textAlignment = UITextAlignmentCenter;
    failedAttemptsLabel.hidden = YES;
    [contentView addSubview:failedAttemptsLabel];
    
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_simple) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    } else {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    }

    if (_failedAttempts > 0) {
        [self showFailedAttempts];
    }
    passcodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShowOnDelay:) name:UIKeyboardWillShowNotification object:nil];
    //初始化数据库
    NSString *fileName = [self dataFilePath];
    //    NSLog(@"%@",fileName);
    
    if (sqlite3_open([fileName UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        
        NSLog(@"打开数据库失败！");
    }else{
        //       char *err;
        NSString *creatSQl = @"CREATE TABLE IF NOT EXISTS PERSOMINFO (ID INTEGER PRIMARY KEY AUTOINCREMENT, password INTEGER)";
        
        [self execSQl:creatSQl];
        NSLog(@"建表成功！");
        
    }
    //初始化数据库
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self showScreenForPhase:0 animated:NO];
    [passcodeTextField becomeFirstResponder];
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationMaskPortraitUpsideDown;
}

- (void)cancel:(id)sender {
    [_delegate PAPasscodeViewControllerDidCancel:self];
}

#pragma mark - implementation helpers

- (void)handleCompleteField {
    NSString *text = passcodeTextField.text;
    switch (_action) {
        case PasscodeActionSet:
            if (phase == 0) {
                _passcode = text;
                messageLabel.text = @"";
                [self showScreenForPhase:1 animated:YES];
            } else {
                if ([text isEqualToString:_passcode]) {
//保存密码到数据库，登陆查找密码如果有就跳到登陆密码界面，如果没有就直接登陆
                    [self addPassWordIntoSQL:_passcode];
//保存密码到数据库，登陆查找密码如果有就跳到登陆密码界面，如果没有就直接登陆
                    if ([_delegate respondsToSelector:@selector(PAPasscodeViewControllerDidSetPasscode:)]) {
                        [_delegate PAPasscodeViewControllerDidSetPasscode:self];
                    }
                } else {
                    [self showScreenForPhase:0 animated:YES];
                    messageLabel.text = NSLocalizedString(@"Passcodes did not match. Try again.", nil);
                }
            }
            break;
            
        case PasscodeActionEnter:
            if ([text isEqualToString:_passcode]) {
                [self resetFailedAttempts];
                if ([_delegate respondsToSelector:@selector(PAPasscodeViewControllerDidEnterPasscode:)]) {
                    [_delegate PAPasscodeViewControllerDidEnterPasscode:self];
                }
            } else {
                [self handleFailedAttempt];
                [self showScreenForPhase:0 animated:NO];
            }
            break;
            
        case PasscodeActionChange:
            if (phase == 0) {
                if ([text isEqualToString:_passcode]) {
                    [self resetFailedAttempts];
                    [self showScreenForPhase:1 animated:YES];
                } else {
                    [self handleFailedAttempt];
                    [self showScreenForPhase:0 animated:NO];
                }
            } else if (phase == 1) {
                _passcode = text;
                messageLabel.text = @"";
                [self showScreenForPhase:2 animated:YES];
            } else {
                if ([text isEqualToString:_passcode]) {
                    if ([_delegate respondsToSelector:@selector(PAPasscodeViewControllerDidChangePasscode:)]) {
                        [_delegate PAPasscodeViewControllerDidChangePasscode:self];
                    }
                } else {
                    [self showScreenForPhase:1 animated:YES];
                    messageLabel.text = NSLocalizedString(@"Passcodes did not match. Try again.", nil);
                }
            }
            break;
    }
}

- (void)handleFailedAttempt {
    _failedAttempts++;
    [self showFailedAttempts];
    if ([_delegate respondsToSelector:@selector(PAPasscodeViewController:didFailToEnterPasscode:)]) {
        [_delegate PAPasscodeViewController:self didFailToEnterPasscode:_failedAttempts];
    }
}

- (void)resetFailedAttempts {
    messageLabel.hidden = NO;
    failedImageView.hidden = YES;
    failedAttemptsLabel.hidden = YES;
    _failedAttempts = 0;
}

- (void)showFailedAttempts {
    messageLabel.hidden = YES;
    failedImageView.hidden = NO;
    failedAttemptsLabel.hidden = NO;
    if (_failedAttempts == 1) {
        failedAttemptsLabel.text = NSLocalizedString(@"1 Failed Passcode Attempt", nil);
    } else {
        failedAttemptsLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%d Failed Passcode Attempts", nil), _failedAttempts];
    }
    [failedAttemptsLabel sizeToFit];
    CGFloat bgWidth = failedAttemptsLabel.bounds.size.width + FAILED_MARGIN*2;
    CGFloat x = floor((contentView.bounds.size.width-bgWidth)/2);
    CGFloat y = PROMPT_HEIGHT+DIGIT_HEIGHT+floor((MESSAGE_HEIGHT-FAILED_HEIGHT)/2);
    failedImageView.frame = CGRectMake(x, y, bgWidth, FAILED_HEIGHT);
    x = failedImageView.frame.origin.x+FAILED_MARGIN;
    y = failedImageView.frame.origin.y+floor((failedImageView.bounds.size.height-failedAttemptsLabel.frame.size.height)/2);
    failedAttemptsLabel.frame = CGRectMake(x, y, failedAttemptsLabel.bounds.size.width, failedAttemptsLabel.bounds.size.height);
}

- (void)passcodeChanged:(id)sender {
    NSString *text = passcodeTextField.text;
    if (_simple) {
        if ([text length] > 4) {
            text = [text substringToIndex:4];
        }
        for (int i=0;i<4;i++) {
            digitImageViews[i].hidden = i >= [text length];
        }
        if ([text length] == 4) {
            [self handleCompleteField];
        }
    } else {
        self.navigationItem.rightBarButtonItem.enabled = [text length] > 0;
    }
}

- (void)showScreenForPhase:(NSInteger)newPhase animated:(BOOL)animated {
    CGFloat dir = (newPhase > phase) ? 1 : -1;
    if (animated) {
        UIGraphicsBeginImageContext(self.view.bounds.size);
        [contentView.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        snapshotImageView = [[UIImageView alloc] initWithImage:snapshot];
        snapshotImageView.frame = CGRectOffset(snapshotImageView.frame, -contentView.frame.size.width*dir, 0);
        [contentView addSubview:snapshotImageView];
    }
    phase = newPhase;
    passcodeTextField.text = @"";
    if (!_simple) {
        BOOL finalScreen = _action == PasscodeActionSet && phase == 1;
        finalScreen |= _action == PasscodeActionEnter && phase == 0;
        finalScreen |= _action == PasscodeActionChange && phase == 2;
        if (finalScreen) {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(handleCompleteField)];
        } else {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Next", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(handleCompleteField)];
        }
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    
    switch (_action) {
        case PasscodeActionSet:
            if (phase == 0) {
                promptLabel.text = _enterPrompt;
            } else {
                promptLabel.text = _confirmPrompt;
            }
            break;
            
        case PasscodeActionEnter:
            promptLabel.text = _enterPrompt;
            break;
            
        case PasscodeActionChange:
            if (phase == 0) {
                promptLabel.text = _changePrompt;
            } else if (phase == 1) {
                promptLabel.text = _enterPrompt;
            } else {
                promptLabel.text = _confirmPrompt;
            }
            break;
    }
    for (int i=0;i<4;i++) {
        digitImageViews[i].hidden = YES;
    }
    if (animated) {
        contentView.frame = CGRectOffset(contentView.frame, contentView.frame.size.width*dir, 0);
        [UIView animateWithDuration:SLIDE_DURATION animations:^() {
            contentView.frame = CGRectOffset(contentView.frame, -contentView.frame.size.width*dir, 0);
        } completion:^(BOOL finished) {
            [snapshotImageView removeFromSuperview];
            snapshotImageView = nil;
        }];
    }
}

- (void)keyboardWillShowOnDelay:(NSNotification *)notification
{
    [self performSelector:@selector(keyboardWillShow:) withObject:nil afterDelay:0];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    UIButton *doneButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 163, 106, 53)];
    [doneButton setTitle:@"" forState:(UIControlStateNormal)];
    [doneButton addTarget:self action:@selector(doneButton:) forControlEvents:UIControlEventTouchUpInside];
    UIWindow * tempWindow = [[[UIApplication sharedApplication]windows]objectAtIndex:1];
    UIView * keyBoard = nil;
    NSLog(@"%@",tempWindow);
    for (int i = 0; i < tempWindow.subviews.count; i ++) {
        keyBoard = [tempWindow.subviews objectAtIndex:i];
        
        [keyBoard addSubview:doneButton];
    }
    
}
/*
 *添加数据库并对设置的密码进行数据的操作进行储存
 *
 */
//加载数据库的路径
-(NSString *)dataFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *myDocPath = [paths objectAtIndex:0];
    NSString *fileName = [myDocPath stringByAppendingPathComponent:DBNAME];
    
    NSLog(@"%@", fileName);
    return fileName;
}
-(void)execSQl:(NSString *)sql
{
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        
        NSLog(@"建表失败！");
    }
}
-(void) addPassWordIntoSQL:(NSInteger)passWord{
    NSString *addSql = @"INSERT INTO PERSOMINFO(ID,password) VALUES(?,?)";
    NSArray *array = [NSArray arrayWithObjects:@"4",passWord,  nil];
    if ([self dealDate:addSql paramsarray:array] != YES) {
        NSLog(@"添加失败！");
    }
    NSLog(@"添加成功！");

}
-(BOOL)dealDate:(NSString *)sql paramsarray:(NSArray *)params{
    
    NSString *filePath = [self dataFilePath];
    //打开数据库
    if (sqlite3_open([filePath UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"打开数据库失败！");
        return NO;
    }
    //编译SQL的语句
    if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL) != SQLITE_OK) {
        NSLog(@"SQL的编译失败！");
        sqlite3_close(db);
        return NO;
    }
    //绑定数据
    for (int i = 0; i < params.count; i++) {
        NSString *value = [params objectAtIndex:i];
        sqlite3_bind_text(stmt, i+1, [value UTF8String], -1, NULL);
    }
    //执行sql的语句
    if (sqlite3_step(stmt) == SQLITE_ERROR || sqlite3_step(stmt) == SQLITE_MISUSE) {
        NSLog(@"执行失败！");
        sqlite3_close(db);
        return NO;
    }
    sqlite3_finalize(stmt);
    sqlite3_close(db);
    return YES;
}

/*
 *添加数据库并对设置的密码进行数据的操作进行储存
 *
 */

@end
