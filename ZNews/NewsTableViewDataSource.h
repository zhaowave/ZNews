//
//  NewsTableViewDataSource.h
//  ZNews
//
//  Created by kfzx-version on 2017/7/7.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsTableViewDataSource : NSObject <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *newsLists;
@end
