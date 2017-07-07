//
//  NewsTableViewDataSource.m
//  ZNews
//
//  Created by kfzx-version on 2017/7/7.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import "NewsTableViewDataSource.h"
#import "NewsCell.h"

@implementation NewsTableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _newsLists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellid";
    //NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    NewsBasicInfo *data = _newsLists[row];;
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[NewsCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        //cell.textLabel.attributedText = [[NSAttributedString alloc] initWithString:data[row] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    }
    cell.newsTitle.text = data.title;
    cell.newsSource.text = data.source;
    UIImage *img = [UIImage new];
    img = [UIImage imageWithContentsOfFile:data.thumbnails[0]];
    if (!img) {
        img = [UIImage imageNamed:@"user_my_wallet"];
    }
    
    cell.thumbNail.image = img;
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
    // UITableViewCell *cell = [];
}

@end
