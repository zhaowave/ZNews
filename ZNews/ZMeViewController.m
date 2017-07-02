//
//  ZMeViewController.m
//  ZNews
//
//  Created by kfzx-version on 2017/6/30.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import "ZMeViewController.h"
#import "LoginView.h"
#import "MeTableviewDataSource.h"
@interface ZMeViewController (){
    UITableView *_tableView;
    MeTableviewDataSource *_dataSource;
}

@end

@implementation ZMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self createTableView];
    NSDictionary *dict = @{
                           @"0":@[@"我的消息",@"最新动态"],
                           @"1":@[@"金币商城",@"我的钱包",@"金币任务"],
                           @"2":@[@"离线阅读",@"夜间模式",@"活动广场",@"意见反馈"],
                           };
    _dataSource.dict = dict;
    
    NSDictionary *imageDict = @{
                           @"0":@[@"user_my_message",@"user_new_fresh"],
                           @"1":@[@"user_coin_mall",@"user_my_wallet",@"user_coin_mission"],
                           @"2":@[@"user_offline_read",@"user_night_mode",@"user_activity_square",@"user_suggest_feedback"],
                           };
    _dataSource.imageDict = imageDict;
    
    
    // Do any additional setup after loading the view.
}
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setStatusBarBackgroundColor:CUSTOMER_RED];
}
- (void) createTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor colorWithHexString:@"f5f5f9"];
    _dataSource = [MeTableviewDataSource new];
    _tableView.delegate = _dataSource;
    _tableView.dataSource = _dataSource;
    
    LoginView *loginView = [[LoginView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/3-35)];
    _tableView.tableHeaderView = loginView;
    
    _tableView.sectionHeaderHeight = 5;
    _tableView.sectionFooterHeight = 0;
    //_tableView.separatorColor = LIGHTGRAYCOLOR;
    _tableView.separatorInset = UIEdgeInsetsZero;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//设置状态条的颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}


@end
