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
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString ;
@end
