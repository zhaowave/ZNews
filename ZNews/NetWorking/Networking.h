//
//  Networking.h
//  ZNews
//
//  Created by wei zhao on 2017/7/9.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^ZHttpCallBack)(NSArray *responseData, NSError *error);

@interface Networking : NSObject
singleton_h(Networking)

- (void) doHttpRequestWithRequest:(NSString*) request andParameter:(NSDictionary*)param withCallback:(ZHttpCallBack) callback;

@end
