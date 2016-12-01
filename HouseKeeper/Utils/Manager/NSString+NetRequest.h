//
//  NSString+NetRequest.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/9/7.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HKAFHTTPSessionManager.h"
#import "MBProgressHUD+Add.h"

@interface NSString (NetRequest)

- (void)httpRequestWithParams:(NSMutableDictionary *)params networkMethod:(NetworkMethod)method andBlock:(void (^)(id data, NSError * error))block;

- (void)httpRequestWithParams:(NSMutableDictionary *)params networkMethod:(NetworkMethod)method isShowHud:(BOOL)isShowHud andBlock:(void (^)(id data, NSError * error))block;

- (void)httpRequestWithParams:(NSMutableDictionary *)params hudView:(MBProgressHUD *)hueView networkMethod:(NetworkMethod)method andBlock:(void (^)(id data, NSError * error))block;



- (void)uploadImageWithParams:(NSMutableDictionary *)params image:(UIImage *)image andBlock:(void (^)(id data, NSError * error))block progressBlock:(void (^)(CGFloat progress))progressBlock;

@end
