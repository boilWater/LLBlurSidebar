//
//  ViewController.m
//  LLBlurSidebar
//
//  Created by Lugede on 14/11/20.
//  Copyright (c) 2014年 lugede.cn. All rights reserved.
//

#import "ViewController.h"
#import "SidebarViewController.h"
#import "NoteBookController.h"
//#import "noteDetailViewController.h"
#import "NoteDetailController.h"
#import "MainCell.h"

@interface ViewController ()

@property NSMutableArray *filteredNoteArray;
//@property UISearchBar *bar;
//@property UISearchDisplayController *searchDispCtrl;
@property (nonatomic, retain) SidebarViewController* sidebarVC;

@end

@implementation ViewController
@synthesize mainUITableView,noteArray,dateArray,titleArray,filteredNoteArray;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.noteArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"note"];
    self.titleArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"title"];
    self.dateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
    [self.mainUITableView reloadData]; // to reload selected cell
    NSLog(@"%@",[self.titleArray objectAtIndex:0]);//可以显示数据
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigation];
    //首页的背景设置
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 74, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    self.mainUITableView = tableView;
//    self.mainUITableView.tableHeaderView = _topUINavigationBar;
    
//    for (int i = 0; i < [self.noteArray count]; i++) {
//        NSLog(@"这是第几个%d是 ：%@",i,[self.noteArray objectAtIndex:i]);
//    }
//    NSLog(@"%@",[self.noteArray objectAtIndex:0]);
    [self.view addSubview:mainUITableView];
    
    // 左侧边栏开始
    UIPanGestureRecognizer* panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetected:)];
    [panGesture delaysTouchesBegan];
    [self.view addGestureRecognizer:panGesture];
    
    self.sidebarVC = [[SidebarViewController alloc] init];
    [self.sidebarVC setBgRGB:0x000000];
    [self.view addSubview:self.sidebarVC.view];
    self.sidebarVC.view.frame  = self.view.bounds;
    // 左侧边栏结束
}

//加载后显示 展示边框
- (void)panDetected:(UIPanGestureRecognizer*)recoginzer
{
    [self.sidebarVC panDetected:recoginzer];
    
}
- (IBAction)show:(id)sender {
    [self.sidebarVC showHideSidebar];
}

#pragma 自己做的修改关于主界面
-(void)addNoteBook:(id)sender{
    NoteBookController *noteBook = [[NoteBookController alloc] init];
    [noteBook setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:noteBook animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [filteredNoteArray count];
    }
    else return [self.noteArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s","我是好人！");
    static NSString *CellIdentifier = @"MainCellID";
    MainCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell==nil) {
        cell = [[MainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    NSString *note;
    NSString *title;
    if (tableView == self.mainUITableView) {
        note = [noteArray objectAtIndex:indexPath.row];
        title = [titleArray objectAtIndex:indexPath.row];
    }
    NSString *date = [dateArray objectAtIndex:indexPath.row];
    NSUInteger charNum = [note length];
    if (charNum < 22) {
        cell.noteContent.text = note;
    }else {
        cell.noteContent.text =[[note substringToIndex:18] stringByAppendingString:@"......"];
    }
    cell.noteTitle.text = title;
    cell.noteDate.text = date;
    
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    NSString *note  = nil;
//    if (tableView == self.searchDisplayController.searchResultsTableView) {
//        note = [filteredNoteArray objectAtIndex:indexPath.row];
//    }
//    //修改
//    else
//        if(tableView == self.mainUITableView){
//        note = [noteArray objectAtIndex:indexPath.row];
//    };
//    NSString *date = [dateArray objectAtIndex:indexPath.row];
//    NSUInteger charnum = [note length];
//    if (charnum < 22) {
//        cell.textLabel.text = note;
//        NSLog(@"%@",note);
//    }
//    else{
//        //显示每个cell的内容
//        cell.textLabel.text = [[note substringToIndex:18] stringByAppendingString:@"..."];
//    }
//    cell.detailTextLabel.text = date;
//    cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
    return cell;
}

#pragma 点击关于主页的日记就进入相应（展示细节的界面）
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NoteDetailController *modifyCtrl = [[NoteDetailController alloc]initWithNibName:nil bundle:nil];
    [modifyCtrl setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:modifyCtrl animated:YES completion:nil];
    NSInteger row = [indexPath row];
    modifyCtrl.index = row;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (void)initNavigation{
    /* Left bar button item */
    UINavigationBar *navigation = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 74)];
    ILBarButtonItem *settingsBtn =
    [ILBarButtonItem barItemWithImage:[UIImage imageNamed:@"gear.png"]
                        selectedImage:[UIImage imageNamed:@"gearSelected.png"]
                               target:self
                               action:@selector(show:)];
    
    self.navigationItem.leftBarButtonItem = settingsBtn;
    
    /* Right bar button item */
    ILBarButtonItem *searchBtn =
    [ILBarButtonItem barItemWithImage:[UIImage imageNamed:@"search.png"]
                        selectedImage:[UIImage imageNamed:@"searchSelected.png"]
                               target:self
                               action:@selector(addNoteBook:)];
    
    self.navigationItem.rightBarButtonItem = searchBtn;
//    [self.view addSubview:settingsBtn];
//    [self.view addSubview:searchBtn];
    [self.view addSubview:navigation];
}
@end
