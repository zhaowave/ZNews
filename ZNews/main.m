//
//  main.m
//  ZNews
//
//  Created by wei zhao on 2017/6/28.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        [OneAPM startWithApplicationToken: @ "75F0D3024DA2D7B2A5A40235581D37DD30"];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
