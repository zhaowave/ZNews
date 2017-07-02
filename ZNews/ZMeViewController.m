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
    _tableView.scrollEnabled = NO;
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
