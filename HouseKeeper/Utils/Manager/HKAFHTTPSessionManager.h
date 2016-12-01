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

//上传图片
- (void)uploudFileWithPath:(NSString *)aPath
                     withParams:(NSMutableDictionary*)params
                 withImage:(UIImage *)image
                  andBlock:(void (^)(NSNumber *code,id data,NSString* message,NSError *error))block
            progressBlock :(void (^)(NSProgress *downloadProgress))progressBlock;

@end
