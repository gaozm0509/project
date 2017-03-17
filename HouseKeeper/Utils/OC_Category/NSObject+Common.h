//
//  NSObject+Common.h
//  IOSFramework
//
//  Created by king on 15-3-25.
//  Copyright (c) 2015年 IOSFramework. All rights reserved.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (Common)

#pragma mark Tip M
- (NSString *)tipFromError:(NSError *)error;
- (void)showError:(NSError *)error;
- (void)showHudTipStr:(NSString *)tipStr;
- (void)showBottomTipStr:(NSString *)tipStr;

#pragma mark File M
//获取fileName的完整地址
-(NSString* )pathInCacheDirectory:(NSString *)fileName;


/**
 *  弹出登录界面
 */
- (void)showLoginViewController;

//清除app中的缓存
- (void)clearCachingAndFinishBlock:(void (^)(BOOL isFinish))block;

//转成json字符串
- (NSString *)stringTOjson;

- (BOOL)isFirstOpen;


/**
 获取app的UDID

 @return app的UDID
 */
- (NSString *)getUDID;

@end
