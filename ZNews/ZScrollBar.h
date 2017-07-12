//
//  ZScrollBar.h
//  ZNews
//
//  Created by zhaowei on 2017/7/11.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZScrollBarDelegate <NSObject>



- (void) refreshNewsListWithType:(int) type;

@end


@interface ZScrollBar : UIScrollView

@property (nonatomic,weak) id<ZScrollBarDelegate> mdeletage;

@property (nonatomic,assign) int selectedIndex;

- (instancetype) init;

@end
