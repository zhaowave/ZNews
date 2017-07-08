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
    [_delegate pushVC:newsDetailVC];
}

@end
