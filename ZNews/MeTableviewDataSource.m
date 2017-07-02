//
//  MeTableviewDataSource.m
//  ZNews
//
//  Created by wei zhao on 2017/7/1.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import "MeTableviewDataSource.h"
#import "MeArticalFuncTableViewCell.h"
@implementation MeTableviewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    NSArray *array = [_dict objectForKey:[NSString stringWithFormat:@"%ld",section-1]];
    return array.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellid";
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section == 0) {
        MeArticalFuncTableViewCell *cell = [[MeArticalFuncTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        return cell;
    }
    NSArray *data = _dict[[NSString stringWithFormat:@"%ld",section-1]];
    NSArray *imgData = _imageDict[[NSString stringWithFormat:@"%ld",section-1]];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.textLabel.attributedText = [[NSAttributedString alloc] initWithString:data[row] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        
        cell.imageView.image = [UIImage imageNamed:imgData[row]];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 90.0;
    }
    return 44.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 8;
    }
    return 5;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 0.0f;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dict.count + 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
   // UITableViewCell *cell = [];
}

//顶部禁止拉动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y < 0) {
        scrollView.bounces = NO;
    }
    else
    {
        scrollView.bounces = YES;
    }
}

@end
