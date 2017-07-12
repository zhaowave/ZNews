//
//  ZHomePageViewController.h
//  ZNews
//
//  Created by kfzx-version on 2017/6/30.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZViewController.h"
#import "ZScrollBar.h"
@interface ZHomePageViewController : ZViewController<ZScrollBarDelegate>
@property (nonatomic, strong) UITableView *newsTableView;
@end
