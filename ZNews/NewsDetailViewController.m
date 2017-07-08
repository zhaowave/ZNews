//
//  NewsDetailViewController.m
//  ZNews
//
//  Created by wei zhao on 2017/7/7.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import "NewsDetailViewController.h"
#import <WebKit/WebKit.h>
@interface NewsDetailViewController (){
    WKWebView *_newsWebView;
}
@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNewsWebView];
}

- (void) addNewsWebView {
    _newsWebView = [[WKWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_newsWebView];
    [_newsWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.requestURLString]]];
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
