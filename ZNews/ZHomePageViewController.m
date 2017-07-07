//
//  ZHomePageViewController.m
//  ZNews
//
//  Created by kfzx-version on 2017/6/30.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import "ZHomePageViewController.h"

@interface ZHomePageViewController ()

@end

@implementation ZHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navigation_logo"]];
    self.navigationItem.titleView = titleView;
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(0,0,40,40);
    [right setImage:[UIImage imageNamed:@"search_icon"] forState:UIControlStateNormal];
    [right setImage:[UIImage imageNamed:@"search_icon_highlight"] forState:UIControlStateHighlighted];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
//        //[left setImage:[UIImage imageNamed:@"nav_live_room"] forState:UIControlStateNormal];
//        [left.imageView setAnimationImages:[NSArray arrayWithObjects:[UIImage imageNamed:@"nav_live_room"],[UIImage imageNamed:@"nav_live_room_one"],[UIImage imageNamed:@"nav_live_room_two"],[UIImage imageNamed:@"nav_live_room_three"],[UIImage imageNamed:@"nav_live_room"], nil]];
//        [left.imageView startAnimating];
//        left.imageView.animationRepeatCount = 0;
//        left.imageView.animationDuration = 2.0f;
//        left.frame = CGRectMake(0,0,40,40);
//        [self.view addSubview:left];
//    });
    NSArray *imagArr = [NSArray arrayWithObjects:[UIImage imageNamed:@"nav_live_room"],[UIImage imageNamed:@"nav_live_room_one"],[UIImage imageNamed:@"nav_live_room_two"],[UIImage imageNamed:@"nav_live_room_three"],[UIImage imageNamed:@"nav_live_room"], nil];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,35,23)];
    imageView.image = [UIImage imageNamed:@"nav_live_room"];
    imageView.animationImages = imagArr;
    imageView.animationDuration = 2;
    imageView.animationRepeatCount = 1;
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:imageView];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    [imageView startAnimating];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
