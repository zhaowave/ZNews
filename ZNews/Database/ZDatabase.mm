//
//  ZDatabase.m
//  ZNews
//
//  Created by wei zhao on 2017/7/8.
//  Copyright © 2017年 wei zhao. All rights reserved.
//

#import "ZDatabase.h"

@interface ZDatabase() {
    WCTDatabase *_database;
}

@end

@implementation ZDatabase
static ZDatabase *_instance;
+ (instancetype) sharedZDatabase {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(_instance == nil){
            _instance = [[ZDatabase alloc] init];
        }
    });
    return _instance;
}

- (WCTDatabase*) getDatabase {
    if (_database == nil) {
        NSMutableString *documentPath = [NSMutableString stringWithFormat:@"%@/Documents/News.db", NSHomeDirectory()];
        NSLog(@"%@ %s",documentPath,__FILE__);
        _database = [[WCTDatabase alloc] initWithPath:documentPath];
    }
    return _database;
}

@end
