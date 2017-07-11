//
//  ScrollTestViewController.m
//  ZNews
//
//  Created by wei zhao on 2017/7/11.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import "ScrollTestViewController.h"

@interface ScrollTestViewController ()

@end

@implementation ScrollTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_scrollView];
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 5*SCREEN_HEIGHT);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    [_scrollView addSubview:label];
    [label setText:@"label"];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
