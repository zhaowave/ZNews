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
    if (_newsLists.count>_imageNewsNumber) {
        return (_newsLists.count - _imageNewsNumber);
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellid";
    NSInteger row = indexPath.row;
    
    if (row == 0) {
        NSMutableArray *array = [NSMutableArray new];
        if (_imageNewsNumber > _newsLists.count ) {
            _imageNewsNumber = _newsLists.count;
        }
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
//    cell.isMove = YES;
//    cell.deleteButtonTitle = @"取消屏蔽";
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
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_imageNewsNumber != 0 && indexPath.row==0) {
        return NO;
    }
    if (_canCommitEditing == YES) {
        return YES;
    }
    return NO;
}
#pragma mark - tableView自带的编辑功能
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"取消屏蔽");
        NewsBasicInfo *data = _newsLists[indexPath.row];
        data.isshow = YES;
        [[NewsService sharedNewsService] updateObject:data];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshnewlistnotify" object:nil];
    }
}
// 选择编辑的样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
// 修改delete的文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"取消屏蔽";
}

// 设置显示多个按钮
//- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
//    //    UITableViewRowAction 通过此类创建按钮
//    /*
//     * 1. 我们在使用一些应用的时候，在滑动一些联系人的某一行的时候，会出现删除、置顶、更多等等的按钮，在iOS8之前，我们都需要自己去实现。到了iOS8，系统已经写好了，只需要一个代理方法和一个类就搞定了
//
//     * 2. iOS8的协议多了一个方法，返回值是数组的tableView:editActionsForRowAtIndexPath:方法，我们可以在方法内部写好几个按钮，然后放到数组中返回，那些按钮的类就是UITableViewRowAction
//
//     * 3. 在UITableViewRowAction类，我们可以设置按钮的样式、显示的文字、背景色、和按钮的事件（事件在Block中实现）
//
//     * 4. 在代理方法中，我们可以创建多个按钮放到数组中返回，最先放入数组的按钮显示在最右侧，最后放入的显示在最左侧
//
//     * 5. 注意：如果我们自己设定了一个或多个按钮，系统自带的删除按钮就消失了...
//     */
//
//
//    UITableViewRowAction * deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//
//    }];
//    deleteRowAction.backgroundColor = [UIColor redColor];
//
//    UITableViewRowAction * topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"置顶" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//
//    }];
//    topRowAction.backgroundColor = [UIColor blueColor];
//
//    UITableViewRowAction * moreRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"更多" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//
//    }];
//
//    return @[deleteRowAction,topRowAction,moreRowAction];
//}



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
