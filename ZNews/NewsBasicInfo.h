//
//  NewsBasicInfo.h
//  ZNews
//
//  Created by zhawei on 2017/7/7.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WCDB/WCDB.h>
#import "ZDatabase.h"

typedef void(^GetNewsList)(NSMutableArray *newsArray, NSError *error);

@interface NewsBasicInfo : NSObject <WCTTableCoding>

@property (strong ,nonatomic) NSString          *Id;
@property (strong ,nonatomic) NSString          *uinnick;
@property (strong ,nonatomic) NSString          *title;
@property (strong ,nonatomic) NSString          *longTitle;
@property (strong ,nonatomic) NSString          *source;
@property (strong ,nonatomic) NSString          *surl;
@property (strong ,nonatomic) NSString          *short_url;
@property (strong ,nonatomic) NSString          *url;
@property (strong ,nonatomic) NSArray           *thumbnails;
@property (strong ,nonatomic) NSArray           *thumbnails_big;
@property (strong ,nonatomic) NSArray           *thumbnails_qqnews;
@property (strong ,nonatomic) NSArray           *thumbnails_qqnews_photo;
@property (strong ,nonatomic) NSArray           *bigImage;
@property (nonatomic, assign) long              timestamp;
@property (nonatomic, assign) long              imagecount;
@property (nonatomic, assign) long              pushCommentCount;
@property (assign ,nonatomic) long              show_expr;
@property (assign ,nonatomic) long              openAds;
@property (assign ,nonatomic) long              openAdsText;
@property (assign ,nonatomic) long              openAdsComment;
@property (assign ,nonatomic) long              openAdsPhotos;
@property (strong ,nonatomic) NSString          *articletype;
@property (strong ,nonatomic) NSString          *media_id;
@property (strong ,nonatomic) NSString          *showType_video;
@property (strong ,nonatomic) NSString          *qishu;
@property (strong ,nonatomic) NSString          *comment;
@property (strong ,nonatomic) NSString          *commentPlacementId;
@property (strong ,nonatomic) NSString          *flag;
@property (strong ,nonatomic) NSString          *showType;
@property (strong ,nonatomic) NSString          *voteId;
@property (strong ,nonatomic) NSString          *voteNum;
@property (strong ,nonatomic) NSString          *weiboid;
@property (strong ,nonatomic) NSString          *abstract;
@property (strong ,nonatomic) NSString          *graphicLiveID;
@property (strong ,nonatomic) NSString          *specialID;

@property (strong ,nonatomic) NSString          *realChlName;
@property (strong ,nonatomic) NSString          *seq_no;
@property (strong ,nonatomic) NSString          *reasonInfo;
@property (strong ,nonatomic) NSString          *a_ver;

WCDB_PROPERTY(Id)
WCDB_PROPERTY(uinnick)
WCDB_PROPERTY(title)
WCDB_PROPERTY(longTitle)
WCDB_PROPERTY(source)
WCDB_PROPERTY(url)
WCDB_PROPERTY(surl)
WCDB_PROPERTY(short_url)
WCDB_PROPERTY(thumbnails)
WCDB_PROPERTY(thumbnails_big)
WCDB_PROPERTY(thumbnails_qqnews)
WCDB_PROPERTY(thumbnails_qqnews_photo)
WCDB_PROPERTY(bigImage)
WCDB_PROPERTY(timestamp)
WCDB_PROPERTY(imagecount)
WCDB_PROPERTY(pushCommentCount)
WCDB_PROPERTY(openAds)
WCDB_PROPERTY(openAdsText)
WCDB_PROPERTY(openAdsComment)
WCDB_PROPERTY(openAdsPhotos)
WCDB_PROPERTY(articletype)
WCDB_PROPERTY(media_id)
WCDB_PROPERTY(showType_video)
WCDB_PROPERTY(qishu)
WCDB_PROPERTY(comment)
WCDB_PROPERTY(commentPlacementId)
WCDB_PROPERTY(flag)
WCDB_PROPERTY(showType)
WCDB_PROPERTY(voteId)
WCDB_PROPERTY(voteNum)
WCDB_PROPERTY(weiboid)
WCDB_PROPERTY(abstract)
WCDB_PROPERTY(graphicLiveID)
WCDB_PROPERTY(specialID)
WCDB_PROPERTY(realChlName)
WCDB_PROPERTY(seq_no)
WCDB_PROPERTY(reasonInfo)
WCDB_PROPERTY(a_ver)


@end

@interface NewsService:NSObject

- (void) createTable;
- (bool) insertObject:(id)object into:(NSString*)name;
- (NSArray*) getNewsInfoFromDB;
- (void) queryNewsWithCallback:(GetNewsList) callback;
singleton_h(NewsService);
@end

//{
//"id": "NEW2017070701916000",
//"uinnick": "腾讯新闻",
//"uinname": "news_news_top",
//"title": "文在寅在德发表演讲：愿条件成熟时会晤金正恩",
//"longtitle": "文在寅在德发表演讲：愿条件成熟时会晤金正恩",
//"surl": "https://view.inews.qq.com/a/NEW2017070701916004",
//"short_url": "https://view.inews.qq.com/a/NEW2017070701916004",
//"weiboid": "",
//"commentid": "2018572318",
//"url": "https://view.inews.qq.com/a/NEW2017070701916004",
//"time": "2017-07-07 09:55:05",
//"timestamp": 1499392915,
//"articletype": "0",
//"media_id": "",
//"showType_video": "normal",
//"thumbnails_big": [],
//"thumbnails": [
//"http://inews.gtimg.com/newsapp_ls/0/1749626775_294195/0"
//],
//"qishu": "",
//"source": "环球网",
//"imagecount": 0,
//"comment": "",
//"flag": "0",
//"tag": [],
//"thumbnails_qqnews": [
//"http://inews.gtimg.com/newsapp_ls/0/1749626775_294195/0"
//],
//"voteId": "",
//"voteNum": "",
//"abstract": "",
//"pushCommentCount": 0,
//"graphicLiveID": "",
//"specialID": "",
//"thumbnails_qqnews_photo": [
//"http://inews.gtimg.com/newsapp_ls/0/1749626775_640330/0"
//],
//"showType": "three",
//"show_expr": 1,
//"openAds": 1,
//"openAdsText": 1,
//"openAdsComment": 1,
//"openAdsPhotos": 0,
//"adTitle": "",
//"gesture": 1,
//"smallWindow": 1,
//"openBigImage": 0,
//"commentPlacementId": "8863362282584659151",
//"showBigPicStyle": "0",
//"bigPicStyleImg": "",
//"FadCid": "",
//"showType_title": 1,
//"disableDelete": 0,
//"picShowType": 0,
//"show_source": 0,
//"forbidCommentUpDown": 0,
//"disableDeclare": 1,
//"forbidExpr": 1,
//"isSensitive": 1,
//"forbidRedPacket": 1,
//"toneScore": "3",
//"qualityScore": "3",
//"bigImage": [
//"http://inews.gtimg.com/newsapp_ls/0/1749626775_870492/0"
//],
//"realChlName": "要闻",
//"a_ver": "04",
//"alg_version": 1,
//"labelList": [],
//"reasonInfo": "",
//"seq_no": "218999392963$$$3-3--要闻-0",
//"article_pos": 1
//}
