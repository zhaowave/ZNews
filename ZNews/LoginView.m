//
//  LoginView.m
//  ZNews
//
//  Created by wei zhao on 2017/6/30.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import "LoginView.h"
#import "Masonry.h"

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = CUSTOMER_RED;
    [self buildView];
    return self;
}

- (void) buildView {
    //登录按钮
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 80, SCREEN_WIDTH/3, 30)];
    loginButton.backgroundColor = [UIColor whiteColor];
    
    [loginButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"登录" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:CUSTOMER_RED}] forState:UIControlStateNormal];
    loginButton.layer.cornerRadius = 2;
    [loginButton addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:loginButton];
    //手机号快速注册
    UIButton *mobileQuickLogon = [UIButton buttonWithType:UIButtonTypePlain];
    [self addSubview:mobileQuickLogon];
    [mobileQuickLogon setAttributedTitle:[[NSAttributedString alloc] initWithString:@"手机号快速注册" attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14], NSForegroundColorAttributeName:WHITECOLOR}] forState:UIControlStateNormal];
    
    [mobileQuickLogon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(loginButton.mas_right).offset(5);
        make.centerY.equalTo(loginButton.mas_centerY);
        make.width.mas_equalTo(SCREEN_WIDTH/3);
        make.height.mas_equalTo(20);
    }];
    
    //设置按钮
    UIButton *setting = [UIButton buttonWithType:UIButtonTypeCustom];
    setting.frame = CGRectMake(SCREEN_WIDTH - 120, 40, 100, 30);
    [setting setImage:[UIImage imageNamed:@"setting_hightlight"] forState:UIControlStateNormal];
    [setting setTitle:@"设置" forState:UIControlStateNormal];
    [setting setTitleEdgeInsets:UIEdgeInsetsMake(0.0 ,7, 0.0,0.0)];//按钮上文字和图片的距离
    [self addSubview:setting];
    //微信登录按钮
    UIButton *wxLoginButton = [[UIButton alloc] init];
    [self addSubview:wxLoginButton];
    [wxLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(loginButton.mas_left);
        make.top.equalTo(loginButton.mas_bottom).offset(30);
        make.width.mas_equalTo(SCREEN_WIDTH/4+2);
        make.height.mas_equalTo(17);
        
        
    }];
    [wxLoginButton setImage:[UIImage imageNamed:@"login_weixin_normal"] forState:UIControlStateNormal];
    [wxLoginButton setImage:[UIImage imageNamed:@"login_weixin_highlight"] forState:UIControlStateHighlighted];
    [wxLoginButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"微信登录" attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15], NSForegroundColorAttributeName:WHITECOLOR}] forState:UIControlStateNormal];
    [wxLoginButton setTitleEdgeInsets:UIEdgeInsetsMake(0.0 ,7, 0.0,0.0)];
    
    //微博登录按钮
    UIButton *wbLoginButton = [[UIButton alloc] init];
    [self addSubview:wbLoginButton];
    [wbLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wxLoginButton.mas_right).offset(30);
        make.top.mas_equalTo(wxLoginButton.mas_top);
        make.width.mas_equalTo(wxLoginButton.mas_width);
        make.height.equalTo(wxLoginButton.mas_height);
        
    }];
    [wbLoginButton setImage:[UIImage imageNamed:@"login_weibo_normal"] forState:UIControlStateNormal];
    [wbLoginButton setImage:[UIImage imageNamed:@"login_weibo_highlight"] forState:UIControlStateHighlighted];
    [wbLoginButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"微博登录" attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15], NSForegroundColorAttributeName:WHITECOLOR}] forState:UIControlStateNormal];
    [wbLoginButton setTitleEdgeInsets:UIEdgeInsetsMake(0.0 ,7, 0.0,0.0)];
    //QQ登录按钮
    UIButton *QQLoginButton = [[UIButton alloc] init];
    [self addSubview:QQLoginButton];
    [QQLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-20);
        make.top.mas_equalTo(wxLoginButton.mas_top);
        make.width.mas_equalTo(wxLoginButton.mas_width);
        make.height.equalTo(wxLoginButton.mas_height);
        
    }];
    [QQLoginButton setImage:[UIImage imageNamed:@"login_qq_normal"] forState:UIControlStateNormal];
    [QQLoginButton setImage:[UIImage imageNamed:@"login_qq_highlight"] forState:UIControlStateHighlighted];
    [QQLoginButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"QQ登录" attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15], NSForegroundColorAttributeName:WHITECOLOR}] forState:UIControlStateNormal];
    [QQLoginButton setTitleEdgeInsets:UIEdgeInsetsMake(0.0 ,7, 0.0,0.0)];
    
    
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
