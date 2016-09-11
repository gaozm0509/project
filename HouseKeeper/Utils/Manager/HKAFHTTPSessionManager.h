//
//  BMNetBasicAPIClient.h
//  MBDoctorClient
//
//  Created by 高泽民 on 15/10/30.
//  Copyright © 2015年 zm. All rights reserved.
//

#import <AFNetworking.h>
typedef enum {
    Get = 0,
    Post,
    Put,
    Delete
} NetworkMethod;
@interface HKAFHTTPSessionManager : AFHTTPSessionManager
+ (HKAFHTTPSessionManager *)sharedJsonClient;
- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSMutableDictionary*)params
                 withMethodType:(int)NetworkMethod
                       andBlock:(void (^)(NSNumber *code,id data,NSString* message,NSError *error))block
                 progressBlock :(void (^)(NSProgress *downloadProgress))progressBlock;

//- (void)uploadImage:(UIImage *)image path:(NSString *)path name:(NSString *)name
//       successBlock:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//       failureBlock:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
//      progerssBlock:(void (^)(CGFloat progressValue))progress;

@end
