//
//  NewsBasicInfo.m
//  ZNews
//
//  Created by zhawei on 2017/7/7.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import "NewsBasicInfo.h"
#import "YYModel.h"
#import "Networking.h"

@implementation NewsBasicInfo

WCDB_IMPLEMENTATION(NewsBasicInfo)
WCDB_SYNTHESIZE(NewsBasicInfo, Id)
WCDB_SYNTHESIZE(NewsBasicInfo, uinnick)
WCDB_SYNTHESIZE(NewsBasicInfo, title)
WCDB_SYNTHESIZE(NewsBasicInfo, longTitle)
WCDB_SYNTHESIZE(NewsBasicInfo, source)
WCDB_SYNTHESIZE(NewsBasicInfo, url)
WCDB_SYNTHESIZE(NewsBasicInfo, surl)
WCDB_SYNTHESIZE(NewsBasicInfo, short_url)
WCDB_SYNTHESIZE(NewsBasicInfo, thumbnails)
WCDB_SYNTHESIZE(NewsBasicInfo, thumbnails_big)
WCDB_SYNTHESIZE(NewsBasicInfo, thumbnails_qqnews)
WCDB_SYNTHESIZE(NewsBasicInfo, thumbnails_qqnews_photo)
WCDB_SYNTHESIZE(NewsBasicInfo, bigImage)
WCDB_SYNTHESIZE(NewsBasicInfo, timestamp)
WCDB_SYNTHESIZE(NewsBasicInfo, imagecount)
WCDB_SYNTHESIZE(NewsBasicInfo, pushCommentCount)
WCDB_SYNTHESIZE(NewsBasicInfo, openAds)
WCDB_SYNTHESIZE(NewsBasicInfo, openAdsText)
WCDB_SYNTHESIZE(NewsBasicInfo, openAdsComment)
WCDB_SYNTHESIZE(NewsBasicInfo, openAdsPhotos)
WCDB_SYNTHESIZE(NewsBasicInfo, articletype)
WCDB_SYNTHESIZE(NewsBasicInfo, media_id)
WCDB_SYNTHESIZE(NewsBasicInfo, showType_video)
WCDB_SYNTHESIZE(NewsBasicInfo, qishu)
WCDB_SYNTHESIZE(NewsBasicInfo, comment)
WCDB_SYNTHESIZE(NewsBasicInfo, commentPlacementId)
WCDB_SYNTHESIZE(NewsBasicInfo, flag)
WCDB_SYNTHESIZE(NewsBasicInfo, showType)
WCDB_SYNTHESIZE(NewsBasicInfo, voteId)
WCDB_SYNTHESIZE(NewsBasicInfo, voteNum)
WCDB_SYNTHESIZE(NewsBasicInfo, weiboid)
WCDB_SYNTHESIZE(NewsBasicInfo, abstract)
WCDB_SYNTHESIZE(NewsBasicInfo, graphicLiveID)
WCDB_SYNTHESIZE(NewsBasicInfo, specialID)
WCDB_SYNTHESIZE(NewsBasicInfo, realChlName)
WCDB_SYNTHESIZE(NewsBasicInfo, seq_no)
WCDB_SYNTHESIZE(NewsBasicInfo, reasonInfo)
WCDB_SYNTHESIZE(NewsBasicInfo, a_ver)

WCDB_PRIMARY(NewsBasicInfo, Id)


+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id"
             };
}

@end
@implementation NewsService

singleton_m(NewsService)

- (void) createTable {
    WCTDatabase *database = [[ZDatabase sharedZDatabase] getDatabase];
    if (![database isTableExists:@"NewsBasicInfo"]) {
        [database createTableAndIndexesOfName:@"NewsBasicInfo" withClass:NewsBasicInfo.class];
    }
}

- (bool) insertObject:(id)object into:(NSString*)name {
    WCTDatabase *database = [[ZDatabase sharedZDatabase] getDatabase];
    return [database insertObject:object into:name];
}
//从数据库取20条新闻 展示
- (NSArray*) getNewsInfoFromDB {
    //NSArray<Message *> *message = [database getObjectsOfClass:Message.class
    //fromTable:@"message"
    //orderBy:Message.localID.order()];
    WCTDatabase *database = [[ZDatabase sharedZDatabase] getDatabase];
    if ([database isTableExists:@"NewsBasicInfo"]) {
        return [database getObjectsOfClass:NewsBasicInfo.class fromTable:@"NewsBasicInfo" limit:20];
    }
    return nil;
}

- (void) queryNewsWithCallback:(GetNewsList) callback {
    NSMutableArray *newsArray = [NSMutableArray new];
    [[Networking sharedNetworking] doHttpRequestWithRequest:NEWSURL andParameter:nil withCallback:^(NSArray *responseData, NSError *error) {
        if (error) {
            ;
        } else {
            NSArray *newsLists = responseData;
            if (newsLists.count == 0) {
                callback(nil,error);
            }
            for (NSDictionary *news in newsLists) {
                NewsBasicInfo *info = [NewsBasicInfo yy_modelWithDictionary:news];
                [[NewsService sharedNewsService] createTable];
                bool success = [[NewsService sharedNewsService] insertObject:info into:@"NewsBasicInfo"];
                if(success)
                    [newsArray insertObject:info atIndex:0];
                NSLog(@"%@",info);
            }
            callback(newsArray, error);
        }
    }];
}


@end
