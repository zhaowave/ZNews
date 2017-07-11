//
//  ZScrollBar.m
//  ZNews
//
//  Created by zhaowei on 2017/7/11.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import "ZScrollBar.h"

#define BARHEIGHT 30

@interface ZScrollBar(){
    UIScrollView *_scrollBar;
}

@end

@implementation ZScrollBar

- (instancetype) init {
    self = [super init];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void) initViews {
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, BARHEIGHT);
    _scrollBar = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, BARHEIGHT)];
    [self addSubview:_scrollBar];
    self.selectedIndex = 0;
    NSArray *dataArray = @[@"头条",@"视频",@"娱乐",@"体育",@"北京",@"财经",@"科技"];
    for (int i = 0; i<dataArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSAttributedString *title = [[NSAttributedString alloc] initWithString:dataArray[i] attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        
        [btn setAttributedTitle:title forState:UIControlStateNormal];
        [_scrollBar addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_scrollBar.mas_left).offset(i*50);
            make.top.equalTo(_scrollBar.mas_top).offset(5);
            make.bottom.equalTo(_scrollBar.mas_bottom);
            make.width.mas_equalTo(50);
        }];
    }
}


@end
