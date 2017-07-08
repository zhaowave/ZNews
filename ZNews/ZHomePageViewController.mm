//
//  ZHomePageViewController.m
//  ZNews
//
//  Created by kfzx-version on 2017/6/30.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import "ZHomePageViewController.h"
#import "AFNetworking.h"
#import "NewsBasicInfo.h"
#import "NewsTableViewDataSource.h"
#import "YYModel.h"

@interface ZHomePageViewController ()<DataSourceDelegate>{
    UITableView *_newsTableView;
    NewsTableViewDataSource *_dataSource;
    NSMutableArray *_newsArray;
    
}

@end

@implementation ZHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateNavigationItems];
    [self createTableView];
    _newsArray = [NSMutableArray new];
    [_newsArray addObjectsFromArray:[[NewsBasicInfo new] getNewsInfoFromDB]];
    _dataSource.newsLists = _newsArray;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];
    
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSArray *imagArr = [NSArray arrayWithObjects:[UIImage imageNamed:@"nav_live_room"],[UIImage imageNamed:@"nav_live_room_one"],[UIImage imageNamed:@"nav_live_room_two"],[UIImage imageNamed:@"nav_live_room_three"],[UIImage imageNamed:@"nav_live_room"], nil];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,35,23)];
    imageView.image = [UIImage imageNamed:@"nav_live_room"];
    imageView.animationImages = imagArr;
    imageView.animationDuration = 2;
    imageView.animationRepeatCount = 1;
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:imageView];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    [imageView startAnimating];
}

- (void) updateNavigationItems {
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navigation_logo"]];
    self.navigationItem.titleView = titleView;
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(0,0,40,40);
    [right setImage:[UIImage imageNamed:@"search_icon"] forState:UIControlStateNormal];
    [right setImage:[UIImage imageNamed:@"search_icon_highlight"] forState:UIControlStateHighlighted];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void) createTableView {
    CGRect frame = self.view.frame;
    frame.origin.y = 0-32;
    _newsTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    _newsTableView.backgroundColor = [UIColor colorWithHexString:@"f5f5f9"];
    _dataSource = [NewsTableViewDataSource new];
    _newsTableView.delegate = _dataSource;
    _newsTableView.dataSource = _dataSource;
    __weak typeof(self) weakSelf = self;
    _dataSource.delegate = weakSelf;
    _newsTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^ {
        [self getNewsLists];
    }];
    
    _newsTableView.separatorInset = UIEdgeInsetsZero;
    _newsTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [self.view addSubview:_newsTableView];
}

- (void) getNewsLists {
    [[NewsBasicInfo new] queryNewsWithCallback:^(NSMutableArray *newsArray, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        } else {
             NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndexesInRange: NSMakeRange(0, newsArray.count)];
            [_newsArray insertObjects:newsArray atIndexes:indexSet];
            [_newsTableView.mj_header endRefreshing];
            [_newsTableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark DataSourceDelegate
-(void) pushVC:(id)vc {
    [self.navigationController pushViewController:vc animated:YES];
    [self.tabBarController.tabBar setHidden:YES];
}

@end
