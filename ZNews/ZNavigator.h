//
//  ZNavigator.h
//  ZNews
//
//  Created by zhaowei on 2017/7/10.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZNavigator : NSObject
{
    UINavigationController *_nav;
}

@property (nonatomic,strong) UINavigationController *nav;

+ (ZNavigator *) sharedZNavigator;

+ (void) navigateTo:(NSString*)viewController;

+ (void) navigateTo:(NSString*)viewController withData:(NSMutableDictionary *)param;

@end
