//
//  ZHomePageViewController.m
//  ZNews
//
//  Created by zhaowei on 2017/6/30.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import "ZHomePageViewController.h"
#import "AFNetworking.h"
#import "NewsBasicInfo.h"
#import "NewsTableViewDataSource.h"
#import "YYModel.h"
#import "ZScrollBar.h"
#import "ADScrollView.h"

@interface ZHomePageViewController ()<ZScrollBarDelegate,UIScrollViewDelegate,ADScrollViewViewDelegate>{
    
    NewsTableViewDataSource *_dataSource;
    NSMutableArray *_newsArray;
    NSMutableArray *_sportsNewsArray;
    UIButton *_refreshButton;
    ZScrollBar *_scrollBar;
    int offset;
    ADScrollView *ADView;
}

@end

@implementation ZHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    offset = 0;
    [self addScrollBar];
    [self refreshButton];
    [self updateNavigationItems];
    [self createTableView];
    [self addDataSource];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageNewsChanged:) name:@"imagenewsnumberchanged" object:nil];
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:NO];
    BOOL change = NO;
    NSMutableArray *tmpNews = [NSMutableArray arrayWithArray:_newsArray];
    for (NewsBasicInfo *info in tmpNews) {
        if (info.isshow == NO) {
            [_newsArray removeObject:info];
            change = YES;
        }
    }
    if (change) {
        [_newsTableView reloadData];
    }
    if (ADView) {
        [ADView startTimer];
    }
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

- (void) addScrollBar {
    _scrollBar = [[ZScrollBar alloc] init];
    _scrollBar.mdeletage = self;
    _scrollBar.delegate = self;
    [self.view addSubview:_scrollBar];
    [_scrollBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.height.mas_equalTo(50);
    }];
}

-(void) imageNewsChanged:(NSNotification*)notify{
    NSDictionary *dict = notify.userInfo;
    NSString *title = dict[@"changed"];
    if ([title isEqualToString:@"屏蔽"]) {
        _dataSource.imageNewsNumber++;
    } else {
        _dataSource.imageNewsNumber--;
    }
    
}
//- (void) addADView {
//    ADView = [[ADScrollView alloc] initWithImages:nil withFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
//    ADView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
//    ADView.pageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"e7240b"];
//    [self.view addSubview:ADView];
//    __weak typeof(self) weakSelf = self;
//    ADView.delegate = self;
//    ADView.time = 5.0;
//    [ADView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_scrollBar.mas_bottom);
//        make.height.mas_equalTo(150);
//        make.left.equalTo(self.view.mas_left);
//        make.right.equalTo(self.view.right);
//    }];
//    
//}

- (void) refreshButton {
    _refreshButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/5, self.tabBarController.tabBar.frame.size.height)];
    _refreshButton.backgroundColor = [UIColor clearColor];
    [self.tabBarController.tabBar addSubview:_refreshButton];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(refreshButtonTapAction)];
    [_refreshButton addGestureRecognizer:tapGesture];
}

- (void) addDataSource {
    _newsArray = [NSMutableArray new];
    _sportsNewsArray = [NSMutableArray new];
    [_newsArray addObjectsFromArray:[[NewsService sharedNewsService] getNewsInfoFromDB:offset]];
    if (_newsArray.count != 0) {
        offset += _newsArray.count;
    }else {
        [self getNewsLists];
    }
    
    _dataSource.newsLists = _newsArray;
    _dataSource.imageNewsNumber = 3;
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
    frame.origin.y = 0;
    frame.size.height = self.view.frame.size.height - 100;
    _newsTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    _newsTableView.backgroundColor = [UIColor colorWithHexString:@"f5f5f9"];
    _dataSource = [NewsTableViewDataSource new];
    _newsTableView.delegate = _dataSource;
    _newsTableView.dataSource = _dataSource;
    _dataSource.hpVC = self;
    _newsTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^ {
        [self getNewsLists];
    }];
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullToRefresh)];
    [footer setTitle:@"Click or drag up to refresh" forState:MJRefreshStateIdle];
    [footer setTitle:@"Loading more ..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"No more data" forState:MJRefreshStateNoMoreData];
    _newsTableView.mj_footer = footer;
    
    _newsTableView.separatorInset = UIEdgeInsetsZero;
    _newsTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [self.view addSubview:_newsTableView];
    
    [_newsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scrollBar.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom).offset(5);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
}

- (void) pullToRefresh {
    int count = _newsArray.count;
    [_newsArray addObjectsFromArray:[[NewsService sharedNewsService] getNewsInfoFromDB:offset]];
    if (count != _newsArray.count) {
        offset += 10;
        [_newsTableView.mj_footer endRefreshing];
        
        [_newsTableView reloadData];
        //NSIndexPath *indexpath = [NSIndexPath indexPathForRow:_newsArray.count-1 inSection:0];
        //[_newsTableView scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        //[_newsTableView.mj_footer setState:MJRefreshStateIdle];
        
    } else {
        //            _newsTableView.mj_footer.
        [_newsTableView.mj_footer endRefreshingWithNoMoreData];
        _newsTableView.mj_footer.hidden = YES;
        //[_newsTableView.mj_footer setRefreshingTitleHidden:YES];
    }
}

- (void) refreshButtonTapAction {
    if (self.tabBarController.selectedIndex == 0) {
        [self getNewsLists];
    } else {
        [self.tabBarController setSelectedIndex:0];
    }
}



- (void) getNewsLists {
    [[NewsService sharedNewsService] queryNewsWithCallback:^(NSMutableArray *newsArray, NSError *error) {
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

#pragma mark ZScrollBarDelegate

- (void) refreshNewsListWithType:(int) type {
    [[NewsService sharedNewsService] querySportsNewsWithCallback:^(NSMutableArray *newsArray, NSError *error) {
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndexesInRange: NSMakeRange(0, newsArray.count)];
        [_sportsNewsArray insertObjects:newsArray atIndexes:indexSet];
        //[_newsTableView.mj_header endRefreshing];
        [_newsArray removeAllObjects];
        [_newsArray addObjectsFromArray:_sportsNewsArray];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_newsTableView reloadData];

        });
    }];
}


#pragma mark - ADScrollViewViewDelegate

- (void)didClickPage:(ADScrollView *)view atIndex:(NSInteger)index
{
    ;
}
@end
