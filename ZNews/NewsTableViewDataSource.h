//
//  NewsTableViewDataSource.h
//  ZNews
//
//  Created by zhaowei on 2017/7/7.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZHomePageViewController;

@interface NewsTableViewDataSource : NSObject <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UIViewControllerPreviewingDelegate>
@property (nonatomic,weak) ZHomePageViewController *hpVC;
@property (nonatomic, strong) NSArray *newsLists;
@property (assign, nonatomic) int         imageNewsNumber;
@end
