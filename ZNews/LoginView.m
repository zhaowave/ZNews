//
//  LoginView.m
//  ZNews
//
//  Created by wei zhao on 2017/6/30.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = CUSTOMER_RED;
    [self buildView];
    return self;
}

- (void) buildView {
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 80, SCREEN_WIDTH/3, 30)];
    loginButton.backgroundColor = [UIColor whiteColor];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:CUSTOMER_RED forState:UIControlStateNormal];
    loginButton.layer.cornerRadius = 2;
    [loginButton addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:loginButton];
}

- (void) loginButtonClicked:(id)sender {
    if ([sender isKindOfClass:[UIButton class]]) {
        [(UIButton*)sender setTitle:@"登录" forState:UIControlStateHighlighted];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
