//
//  ZMainTabBarController.m
//  ZNews
//
//  Created by kfzx-version on 2017/6/30.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import "ZMainTabBarController.h"
#import "UIColor+HexString.h"

@interface ZMainTabBarController ()

@end

@implementation ZMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTabControllers];
    if (TEST_MODE) {
        self.selectedIndex = 4;
    }
    
    // Do any additional setup after loading the view.
}

- (void) createTabControllers {
    self.tabBar.tintColor = CUSTOMER_RED;
    self.navigationController.navigationBar.backgroundColor = CUSTOMER_RED;
    self.viewControllers = @[
                             [self createVCWithName:@"ZHomePageViewController" normalImageName:@"tabbar_icon_news_normal_41x53_@2x" HLImageName:@"tabbar_icon_news_highlight_41x53_@2x" andTitle:@"首页"],
                             [self createVCWithName:@"ZImportantNewsViewController" normalImageName:@"tabbar_icon_importantNews_normal_15x20_@2x" HLImageName:@"tabbar_icon_importantNews_highlight_15x20_@2x" andTitle:@"要闻"],
                             [self createVCWithName:@"ZLiveViewController" normalImageName:@"tabbar_icon_live_normal_20x17_@2x" HLImageName:@"tabbar_icon_live_highlight_20x17_@2x" andTitle:@"直播"],
                             [self createVCWithName:@"ZVideoViewController" normalImageName:@"tabbar_icon_video_normal_19x19_@2x" HLImageName:@"tabbar_icon_video_highlight_19x19_@2x" andTitle:@"视频"],
                             [self createVCWithName:@"ZMeViewController" normalImageName:@"tabbar_icon_me_normal_19x19_@2x" HLImageName:@"tabbar_icon_me_highlight_19x19_@2x" andTitle:@"我"]
                        ];
}

/**
 *  返回取消渲染的image
 */
- (UIImage*)removeRendering:(NSString*)imageName
{
    UIImage* image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

-(UINavigationController*) createVCWithName:(NSString*)name normalImageName:(NSString*)normalImgName HLImageName:(NSString*)HLImageName andTitle:(NSString*) titleText{
    
    //创建图片
    UIImage *normal = [self removeRendering:normalImgName];
    UIImage *selected = [self removeRendering:HLImageName];
    //创建controller
    UIViewController *VC = [NSClassFromString(name) new];
    VC.title = titleText;
    //导航
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:VC];
    nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:titleText image:normal selectedImage:selected];
    [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    nav.navigationBar.tintColor = [UIColor whiteColor];
    nav.navigationBar.barTintColor = [UIColor greenColor];
    return nav;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
