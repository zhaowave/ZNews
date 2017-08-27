//
//  NewsDetailViewController.h
//  ZNews
//
//  Created by wei zhao on 2017/7/7.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import "ZViewController.h"
#import <WebKit/WebKit.h>
//@protocol NewsDetailDelegate
//- (void) donnotShowANews:(BOOL)show;
//@end


@interface NewsDetailViewController : ZViewController<WKNavigationDelegate>
@property (nonatomic, strong) NSString *requestURLString;
//@property (weak, nonatomic)  id<NewsDetailDelegate> delegate;
@end
