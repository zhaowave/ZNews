//
//  Networking.m
//  ZNews
//
//  Created by wei zhao on 2017/7/9.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import "Networking.h"

@implementation Networking
singleton_m(Networking)

- (void) doHttpRequestWithRequest:(NSString*) request andParameter:(NSDictionary*)param withCallback:(ZHttpCallBack) callback {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSURLSessionTask *task =  [manager POST:request parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([request isEqualToString:NEWSURL]) {
            NSArray *newsLists = responseObject[@"newslist"];
            callback(newsLists,nil);
        }
        callback(responseObject,nil);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        callback(nil,error);
    }];
    [task resume];
}

@end
