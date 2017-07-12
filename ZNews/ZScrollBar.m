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
    //UIScrollView *_scrollBar;
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
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, BARHEIGHT);
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
   
    self.selectedIndex = 0;
    dataArray = @[@"头条",@"视频",@"娱乐",@"体育",@"北京",@"财经",@"科技",@"汽车",@"社会",@"军事",@"时尚",@"汽车",@"社会",@"军事",@"时尚",];
    _buttonArray = [NSMutableArray new];
    self.contentSize = CGSizeMake(dataArray.count*50, 0);
    CGRect frame = self.frame;
    frame.size.width = self.contentSize.width;
    UIView *buttonView = [[UIView alloc] initWithFrame:frame];
    //buttonView.backgroundColor = [UIColor blueColor];
    [self addSubview:buttonView];

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
        //选中的不是之前选中的，把上一次选中的状体恢复
        if (_selectedIndex != btn.tag) {
            NSAttributedString *title = [[NSAttributedString alloc] initWithString:dataArray[_selectedIndex] attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:14]}];
            [forwardBtn setAttributedTitle:title forState:UIControlStateNormal];
        }
        //体育
        if (btn.tag == 3) {
            //刷新数据
            [_mdeletage refreshNewsListWithType:btn.tag];
        }
        _selectedIndex = btn.tag;//当前选中的位置
//        if (btn.frame.origin.x > SCREEN_WIDTH/2) {
//            //NSLog(@"%@",btn.frame);
//            [self scrollRectToVisible:CGRectMake(btn.frame.origin.x - SCREEN_WIDTH/2, 100, SCREEN_WIDTH, BARHEIGHT) animated:YES];
//        }
    }
    
}


@end
