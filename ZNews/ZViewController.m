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
    
//    self.navigationController.navigationBar.backgroundColor = ;
//    self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:CUSTOMER_RED];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
