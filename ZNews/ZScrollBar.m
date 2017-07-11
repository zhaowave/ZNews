//
//  ZScrollBar.m
//  ZNews
//
//  Created by zhaowei on 2017/7/11.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import "ZScrollBar.h"
#import "ScrollTestViewController.h"

#define BARHEIGHT 45

@interface ZScrollBar(){
    UIScrollView *_scrollBar;
    NSArray *dataArray;
    NSMutableArray *_buttonArray;
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
    _scrollBar = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, BARHEIGHT)];
    _scrollBar.showsHorizontalScrollIndicator = NO;
    _scrollBar.showsVerticalScrollIndicator = NO;
    UIView *buttonView = [[UIView alloc] initWithFrame:_scrollBar.frame];
    [_scrollBar addSubview:buttonView];
    //_scrollBar.backgroundColor = LIGHTGRAYCOLOR;
    [self addSubview:_scrollBar];
    self.selectedIndex = 0;
    dataArray = @[@"头条",@"视频",@"娱乐",@"体育",@"北京",@"财经",@"科技",@"汽车",@"社会",@"军事",@"时尚",@"汽车",@"社会",@"军事",@"时尚",];
    _buttonArray = [NSMutableArray new];
    _scrollBar.contentSize = CGSizeMake(dataArray.count*50, BARHEIGHT);
    for (int i = 0; i<dataArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSAttributedString *title = [[NSAttributedString alloc] initWithString:dataArray[i] attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        btn.tag = i;
        [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn setAttributedTitle:title forState:UIControlStateNormal];
        [buttonView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(buttonView.mas_left).offset(i*50);
            make.top.equalTo(buttonView.mas_top).offset(5);
            make.bottom.equalTo(buttonView.mas_bottom);
            make.width.mas_equalTo(BARHEIGHT);
        }];
        [_buttonArray addObject:btn];
    }
    _selectedIndex = 0;
}

- (void) buttonClicked:(id) sender {
    if ([sender isKindOfClass:[UIButton class]]) {
        UIButton *btn = (UIButton*)sender;
        NSAttributedString *title = [[NSAttributedString alloc] initWithString:dataArray[btn.tag] attributes:@{NSForegroundColorAttributeName:CUSTOMER_RED,NSFontAttributeName:[UIFont systemFontOfSize:18]}];
        [btn setAttributedTitle:title forState:UIControlStateNormal];
        
        UIButton *forwardBtn = _buttonArray[_selectedIndex];
        //选中的不是之前选中的
        if (_selectedIndex != btn.tag) {
            NSAttributedString *title = [[NSAttributedString alloc] initWithString:dataArray[btn.tag] attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:14]}];
            [forwardBtn setAttributedTitle:title forState:UIControlStateNormal];
        }
        
        _selectedIndex = btn.tag;//当前选中的位置
        if (btn.frame.origin.x > SCREEN_WIDTH/2) {
            [_scrollBar scrollRectToVisible:CGRectMake(0, 0, SCREEN_WIDTH, BARHEIGHT) animated:YES];
        }
    }
    
}


@end
