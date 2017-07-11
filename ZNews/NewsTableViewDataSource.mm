//
//  NewsTableViewDataSource.m
//  ZNews
//
//  Created by kfzx-version on 2017/7/7.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import "NewsTableViewDataSource.h"
#import "NewsDetailViewController.h"
#import "NewsCell.h"
#import "NewsBasicInfo.h"
#import "AppDelegate.h"
#import "ZHomePageViewController.h"

@implementation NewsTableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _newsLists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellid";
    NSInteger row = indexPath.row;
    
    NewsBasicInfo *data = _newsLists[row];
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[NewsCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    cell.newsTitle.text = data.title;
    cell.newsSource.text = data.source;
    [cell.thumbNail setShowActivityIndicatorView:YES];
    [cell.thumbNail setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [cell.thumbNail sd_setImageWithURL:[NSURL URLWithString:data.thumbnails[0]]];
    cell.newsSource.text = data.source;
    if ([_hpVC respondsToSelector:@selector(traitCollection)]) {
        if ([_hpVC traitCollection].forceTouchCapability == UIForceTouchCapabilityAvailable) {
            [_hpVC registerForPreviewingWithDelegate:self sourceView:cell];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NewsDetailViewController *newsDetailVC = [NewsDetailViewController new];
    NewsBasicInfo *data = _newsLists[indexPath.row];
    newsDetailVC.requestURLString = data.url;
    [ZNavigator navigateTo:@"NewsDetailViewController" withData:@{@"url":data.url}];
}

#pragma mark UIViewControllerPreviewing
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    NewsDetailViewController *detailVC = [[NewsDetailViewController alloc] init];
    NSIndexPath *indexPath = [_hpVC.newsTableView indexPathForCell:(UITableViewCell* )[previewingContext sourceView]];
    NewsBasicInfo *news = _newsLists[indexPath.row];
    detailVC.requestURLString = news.url;
    detailVC.preferredContentSize = CGSizeMake(0.0f,500.0f);
    return detailVC;
    
}
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit NS_AVAILABLE_IOS(9_0) {
    
    //UINavigationController *nav = (UINavigationController*)viewControllerToCommit;
    //NewsDetailViewController *detailVC = [nav.viewControllers firstObject];
    [_hpVC showViewController:viewControllerToCommit sender:_hpVC];
    _hpVC.tabBarController.tabBar.hidden = YES;
}

@end
