//
//  ZViewController.m
//  ZNews
//
//  Created by kfzx-version on 2017/6/30.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import "ZViewController.h"
#import "UIColor+HexString.h"


@interface ZViewController ()

@end

@implementation ZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        [self.navigationController.navigationBar setBarTintColor:CUSTOMER_RED];
    }
    else{
        [self.navigationController.navigationBar setTintColor:CUSTOMER_RED];
    }
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //self.navigationController.tabBarController.tabBar.hidden = 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}



@end
