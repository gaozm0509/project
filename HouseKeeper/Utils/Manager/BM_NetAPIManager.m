//
//  BM_NetAPIManager.m
//  MBDoctorClient
//
//  Created by 高泽民 on 15/10/30.
//  Copyright © 2015年 zm. All rights reserved.
//

#import "BM_NetAPIManager.h"
#import "HKAFHTTPSessionManager.h"

@implementation BM_NetAPIManager
+ (instancetype)sharedManager {
    static BM_NetAPIManager *shared_manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared_manager = [[self alloc]init];
    });
    return shared_manager;
}

//
//- (void)request_AllCities_WithParams:(id)params Path:(NSString *)path andBlock:(void (^)(id, NSError *))block{
//    [[BMNetBasicAPIClient sharedJsonClient] requestJsonDataWithPath:path withParams:params withMethodType:Post andBlock:^(NSNumber *code, id data, NSString *message, NSError *error) {
//        if (data) {
//            block(data, nil);
//        }else{
//            block(nil, error);
//        }
//    }];
//}


@end
