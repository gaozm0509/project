//
//  NSString+Common.h
//  IOSFramework
//
//  Created by king on 15-3-25.
//  Copyright (c) 2015年 IOSFramework. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Common)
- (NSString *)md5Str;
- (NSString*) sha1Str;



- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)getHeightWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)getWidthWithFont:(UIFont *)font constrainedToSize:(CGSize)size;


+ (NSString *)sizeDisplayWithByte:(CGFloat)sizeOfByte;

- (NSString *)trimWhitespace;
- (BOOL)isEmpty;
//判断是否为整形
- (BOOL)isPureInt;
//判断是否为浮点形
- (BOOL)isPureFloat;

- (NSString *)stringByTrimmingLeftCharactersInSet:(NSCharacterSet *)characterSet;
- (NSString *)stringByTrimmingRightCharactersInSet:(NSCharacterSet *)characterSet;
- (CGSize)sizeWithFont:(UIFont *)font Size:(CGSize)size;


/**
 去除字符串中的变html标签
 
 @param html html字符串
 @return 返回去除后的字符串
 */
+ (NSString *)filterHTML:(NSString *)html;


/**
 字符串转化为字典

 @param jsonString json字符串
 @return 返回的字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString ;

/*
 *对象转成json字符串
 */
+ (NSString *)JSONString:(id)obj;

/**
 判断是否是电话
 
 @return 是或者否
 */
- (BOOL)isPhoneNum;

@end
