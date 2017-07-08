//
//  ZDatabase.h
//  ZNews
//
//  Created by wei zhao on 2017/7/8.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WCDB/WCDB.h>
@interface ZDatabase : NSObject

+ (instancetype) sharedZDatabase;
- (WCTDatabase*) getDatabase;

@end
