//
//  ZNavigator.m
//  ZNews
//
//  Created by zhaowei on 2017/7/10.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import "ZNavigator.h"
#import "AppDelegate.h"
#import "ZViewController.h"

@implementation ZNavigator

@synthesize nav = _nav;

singleton_m(ZNavigator);

+ (void) navigateTo:(NSString*)viewController {
    [[self sharedZNavigator] navigateTo:viewController withData:nil];
}

+ (void) navigateTo:(NSString*)viewController withData:(NSMutableDictionary *)param {
    [[self sharedZNavigator] navigateTo:viewController withData:param];
}

- (void) navigateTo:(NSString*)viewController withData:(NSMutableDictionary *)param {
    ZViewController *classObject = (ZViewController*)[NSClassFromString(viewController) new];
    //UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:classObject];
    classObject.param = param;
    AppDelegate *delegate = (AppDelegate *)([UIApplication sharedApplication].delegate);
    UINavigationController *nav = [delegate.tabBarController selectedViewController];
    nav.tabBarController.tabBar.hidden = YES;
    self.nav = nav;
    [self.nav pushViewController:classObject animated:YES];
}

@end
