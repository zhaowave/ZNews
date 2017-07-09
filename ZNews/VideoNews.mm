//
//  VideoNews.m
//  ZNews
//
//  Created by wei zhao on 2017/7/9.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import "VideoNews.h"

#import "Networking.h"
@implementation VideoNews

@end

@implementation VideoNewsService
singleton_m(VideoNewsService)

-(void) queryVideoNewsWithCallback:(GetNewsList) callback {
    
    [[Networking sharedNetworking] doHttpRequestWithRequest:VIDEONEWSURL andParameter:nil withCallback:^(NSArray *responseData, NSError *error) {
        if (error) {
            
        }else {
            
        }
    }];
}
@end
