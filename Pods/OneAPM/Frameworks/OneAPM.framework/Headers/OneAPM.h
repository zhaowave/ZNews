//
//  OneAPM.h
//  BlueWare
//
//  Created by lidong on 14-7-15.
//  Copyright (c) 2014年 BLUEWARE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OneAPM : NSObject

/******************************************************************************
 * Function: + (void)startWithApplicationToken:(NSString *)token
 * Parameters:
 *  token:
 *       the token string got from www.OneAPM.com
 ******************************************************************************/
+ (void)startWithApplicationToken:(NSString *)token;

/******************************************************************************
 * Function: + (void)startWithApplicationToken:(NSString *)token
 * Parameters:
 *  token:
 *       the string given on www.oneapm.com
 *  isSSL: (Default is YES)
 *        YES - communicate with host by https
 *        NO  - communicate with host by http
 ******************************************************************************/
+ (void)startWithApplicationToken:(NSString *)token
                     withSecurity:(BOOL)isSSL;

/*******************************************************************************
 * Function: + (void)setAppPublishChannel:(NSString *)channel;
 * Parameters:
 ******************************************************************************/
+ (void)setAppPublishChannel:(NSString *)channel;

/******************************************************************************
 * Function: + (void)disableZLib
 * use zlib is enabled by default.
 * Call this before startWithApplicationToken to disable.
 ******************************************************************************/
+ (void)disableZLib;

/******************************************************************************
 * Function: + (void)printLog:(BOOL)enable
 * Parameters:
 *  enable: (Default is NO)
 *       YES - enable agent log printing
 *       NO  - disable agent log printing.
 ******************************************************************************/
+ (void)printLog:(BOOL)enable;

/******************************************************************************
 * Function: + (void)disableCrashReport
 * Crash report is enabled by default.
 * Call this before startWithApplicationToken to disable.
 ******************************************************************************/
+ (void)disableCrashReport __attribute__((deprecated));

/******************************************************************************
 * Function: + (void)setCustomInfo:(NSString *)info
 * set custom information to identify a certain user.
 * Call this after startWithApplicationToken.
 ******************************************************************************/
+ (void)setCustomInfo:(NSString *)info;

+ (void)setCustomInfo:(NSString *)info withExtra:(NSDictionary *)extra;

#pragma mark - Enterprise Only

/*******************************************************************************
 * Function: + (void)setHost:(NSString *)host
 * Parameters:
 *  host: The host and port of OneAPM Server
 * Call this before startWithApplicationToken.
 ******************************************************************************/
+ (void)setHost:(NSString *)host;

@end
