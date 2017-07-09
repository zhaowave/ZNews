//
//  VideoNews.h
//  ZNews
//
//  Created by wei zhao on 2017/7/9.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsBasicInfo.h"
@interface VideoNews : NSObject

@end

@interface VideoNewsService : NSObject
singleton_h(VideoNewsService)
- (void) queryVideoNewsWithCallback:(GetNewsList) callback;

@end
