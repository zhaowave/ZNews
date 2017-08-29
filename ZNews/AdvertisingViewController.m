//
//  AdvertisingViewController.m
//  ZNews
//
//  Created by kfzx-version on 2017/8/29.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import "AdvertisingViewController.h"
#include "AppDelegate.h"
#import "ZMainTabBarController.h"

@interface AdvertisingViewController ()
@property (strong, nonatomic) UIButton *timerButton;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) UIImageView *adImgView;
@property (assign, nonatomic) int adTime;
@end

@implementation AdvertisingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _adTime = 5;
    self.view.backgroundColor = CUSTOMER_RED;
    _adImgView = [UIImageView new];
    [self.view addSubview:_adImgView];
    _adImgView.frame = self.view.frame;
    _timerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_timerButton setTitle:[NSString stringWithFormat:@"跳过 %d s",_adTime] forState:UIControlStateNormal];
    [self.view addSubview:_timerButton];
    [self.view bringSubviewToFront:_timerButton];
    [_timerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(10);
        make.top.equalTo(self.view.mas_top).offset(20);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(160);
    }];
    _timerButton.backgroundColor = [UIColor blueColor];
    [_timerButton addTarget:self action:@selector(showMainController) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://ss.csdn.net/p?https://mmbiz.qpic.cn/mmbiz_jpg/BnSNEaficFAaMOaxdBakeDkAjqxccHlsw16cic9HuSmG24jdg5JgA5tJ0p2aicEY3sC2OWu6BHW8nA0NickpwuCibog/640?wx_fmt=jpeg"]]];
    _adImgView.image = image;
    _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(changeTime) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

-(void) changeTime {
    if (_adTime != 0) {
        _adTime--;
        [_timerButton setTitle:[NSString stringWithFormat:@"跳过 %d s",_adTime] forState:UIControlStateNormal];
    } else {
        [_timer invalidate];
        [_timerButton setTitle:[NSString stringWithFormat:@"跳过 %d s",_adTime] forState:UIControlStateNormal];
        [self showMainController];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) showMainController {
    AppDelegate *delegate = (AppDelegate *)([UIApplication sharedApplication].delegate);
    ZMainTabBarController *zTabBarContrller = [ZMainTabBarController new];
    [zTabBarContrller.navigationController setNavigationBarHidden:YES animated:NO];
    delegate.tabBarController = zTabBarContrller;
    delegate.window.rootViewController = zTabBarContrller;
    [delegate.window makeKeyAndVisible];
}

@end
