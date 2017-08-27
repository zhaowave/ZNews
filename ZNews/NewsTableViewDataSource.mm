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
#import "ScrollNewsCellTableViewCell.h"

@interface NewsTableViewDataSource(){
    NSIndexPath *selectIndexPath;
    
}
@end;
@implementation NewsTableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _newsLists.count - _imageNewsNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellid";
    NSInteger row = indexPath.row;
    
    if (row == 0) {
        NSMutableArray *array = [NSMutableArray new];
        for(int i = 0;i<_imageNewsNumber;i++){
            [array addObject:_newsLists[i]];
        }
        if (array.count != 0) {
            ScrollNewsCellTableViewCell *scrollCell = [[ScrollNewsCellTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil andImageArray:array];
            return scrollCell;
        }
    }
    NewsBasicInfo *data = _newsLists[row+_imageNewsNumber];
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
    if (indexPath.row == 0 && _imageNewsNumber!=0) {
        return 150;
    }
    return 100;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    selectIndexPath = indexPath;//当前选中的indexpath
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
   // NewsDetailViewController *newsDetailVC = [NewsDetailViewController new];
   // newsDetailVC.delegate = self;
    NewsBasicInfo *data = _newsLists[indexPath.row];
    //newsDetailVC.requestURLString = data.url;
    [ZNavigator navigateTo:@"NewsDetailViewController" withData:@{@"url":data.url,@"News":data}];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
    headerView.backgroundColor = CUSTOMER_RED;
    return headerView;
    
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
    headerView.backgroundColor = CUSTOMER_RED;
    return headerView;
    
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
