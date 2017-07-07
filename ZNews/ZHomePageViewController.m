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

@interface ZHomePageViewController (){
    UITableView *_newsTableView;
    NewsTableViewDataSource *_dataSource;
    
}

@end

@implementation ZHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateNavigationItems];
    [self createTableView];
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
    _newsTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _newsTableView.backgroundColor = [UIColor colorWithHexString:@"f5f5f9"];
    _dataSource = [NewsTableViewDataSource new];
    _newsTableView.delegate = _dataSource;
    _newsTableView.dataSource = _dataSource;

    _newsTableView.separatorInset = UIEdgeInsetsZero;
    _newsTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [self.view addSubview:_newsTableView];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
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
    [self getNewsLists];
}

- (void) getNewsLists {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://r.inews.qq.com/getQQNewsUnreadList?store=1&apptype=ios&__qnr=1f0f1ee4f0b8&activefrom=icon&omgid=5c70eb6ca10ccc416d99e15a5b285ea9ea0c0010112107&idfa=CD72C779-D2E1-494E-ACB8-69192D1CC413&startarticleid=&global_info=0%7C&appver=11.0_qqnews_5.3.7&network_type=gsm_4g&qqnews_refpage=CNewsDetailViewController&omgbizid=fbd4009c7959824bcac8cb73062f8d2e03ab0060112601&screen_height=667&devid=9BED6638-EF2B-46DB-8CDF-672FE6AB327B&screen_scale=2&screen_width=375&isJailbreak=0&device_model=iPhone9%2C1"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSMutableArray *newsArray = [NSMutableArray new];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
            NSArray *newsLists = responseObject[@"newslist"];
            //NSDictionary *news = newsLists[0];
            for (NSDictionary *news in newsLists) {
                NewsBasicInfo *info = [NewsBasicInfo yy_modelWithDictionary:news];
                [newsArray addObject:info];
                NSLog(@"%@",info);
            }
            
            _dataSource.newsLists = newsArray;
            dispatch_async(dispatch_get_main_queue(), ^{
                [_newsTableView reloadData];
            });
            
        }
    }];
    [dataTask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
