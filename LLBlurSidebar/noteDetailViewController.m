//
//  modifyViewController.m
//  simpleNote
//
//  Created by Vic on 13-11-21.
//  Copyright (c) 2013年 vic. All rights reserved.
//

#import "noteDetailViewController.h"
#import "ViewController.h"

@interface noteDetailViewController ()<UIAlertViewDelegate>
@property UITextView *mytextView;
@end

@implementation noteDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
	// Do any additional setup after loading the view.
    UIToolbar *topNavigation;

    UIBarButtonItem *savebtn = [[UIBarButtonItem alloc]initWithTitle:@"save" style:UIBarButtonItemStylePlain target:self action:@selector(saveclicked)];
    
    UIBarButtonItem *delbtn = [[UIBarButtonItem alloc]initWithTitle:@"delete" style:UIBarButtonItemStylePlain target:self action:@selector(deleteclicked)];
    NSArray *bararray = [NSArray arrayWithObjects:delbtn,savebtn, nil];
    
    topNavigation = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 64)];
    [topNavigation setBarStyle:UIBarStyleDefault];
    [topNavigation sizeToFit];
    [topNavigation setItems:bararray animated:YES];
    [self.view addSubview:topNavigation];
    
//    [self.view addSubview:topNavigation];
    
    
    self.mytextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 66, 310, 320)];
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"note"];
    NSString *oldtext = [array objectAtIndex:self.index];
    self.mytextView.text = oldtext;
    [self.view addSubview:self.mytextView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveclicked{
    NSArray *tempArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"note"];
    NSMutableArray *mutableArray = [tempArray mutableCopy];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init ];
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    NSDate *now = [NSDate date];
    NSString *datestring = [dateFormatter stringFromDate:now];
    NSString *textstring = [self.mytextView text];
    [mutableArray removeObjectAtIndex:self.index];
    [mutableArray insertObject:textstring atIndex:0];
    [[NSUserDefaults standardUserDefaults] setObject:mutableArray forKey:@"note"];
    ViewController *rootctrl = [[ViewController alloc]init];
    rootctrl.noteArray = mutableArray;
    
    NSArray *tempDateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
    NSMutableArray *mutableDateArray = [tempDateArray mutableCopy];
    [mutableDateArray removeObjectAtIndex:self.index];
    [mutableDateArray insertObject:datestring atIndex:0 ];
    rootctrl.dateArray = mutableDateArray;
    [[NSUserDefaults standardUserDefaults] setObject:mutableDateArray forKey:@"date"];
    
    [self.mytextView resignFirstResponder];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"save success!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alertView show];
}

-(void)deleteclicked{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"Are you sure to delete this note?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        NSArray *tempArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"note"];
        NSMutableArray *mutableArray = [tempArray mutableCopy];
        [mutableArray removeObjectAtIndex:self.index];
        [[NSUserDefaults standardUserDefaults] setObject:mutableArray forKey:@"note"];
        ViewController *rootctrl = [[ViewController alloc]init];
        rootctrl.noteArray = mutableArray;
        
        NSArray *tempDateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
        NSMutableArray *mutableDateArray = [tempDateArray mutableCopy];
        [mutableDateArray removeObjectAtIndex:self.index];
        [[NSUserDefaults standardUserDefaults] setObject:mutableDateArray forKey:@"date"];
        rootctrl.dateArray = mutableDateArray;
        
        ViewController *viewController = [[ViewController alloc] init];
        [viewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self presentViewController:viewController animated:YES completion:nil];
    }
    else if (buttonIndex == 1) return;
}

@end
