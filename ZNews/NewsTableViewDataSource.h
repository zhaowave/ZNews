//
//  NewsTableViewDataSource.h
//  ZNews
//
//  Created by kfzx-version on 2017/7/7.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataSourceDelegate
-(void) pushVC:(id)vc;

@end

@interface NewsTableViewDataSource : NSObject <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic,weak) id <DataSourceDelegate> delegate;
@property (nonatomic, strong) NSArray *newsLists;
@end
