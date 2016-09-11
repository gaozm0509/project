//
//  NSString+NetRequest.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/9/7.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "NSString+NetRequest.h"

@implementation NSString (NetRequest)

- (void)httpRequestWithParams:(NSMutableDictionary *)params networkMethod:(NetworkMethod)method andBlock:(void (^)(id, NSError *))block{
    [[HKAFHTTPSessionManager sharedJsonClient]requestJsonDataWithPath:self withParams:params withMethodType:method andBlock:^(NSNumber *code, id data, NSString *message, NSError *error) {
        if (data) {
            block(data, nil);
        }else{
            block(message, error);
        }
    } progressBlock:^(NSProgress *downloadProgress) {
        
    }];
}

@end
