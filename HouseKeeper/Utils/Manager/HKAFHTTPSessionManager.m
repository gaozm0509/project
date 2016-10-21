//
//  EYNetBasicAPIClient.m
//  Electricity
//
//  Created by 高泽民 on 15/7/24.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "HKAFHTTPSessionManager.h"




@implementation HKAFHTTPSessionManager
+ (HKAFHTTPSessionManager *)sharedJsonClient {
    static HKAFHTTPSessionManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[HKAFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:kApi_Host]];
    });
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    // 组织报文头
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    //[self.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
    [self.requestSerializer setValue:@"application/json; charset=utf-8"forHTTPHeaderField:@"Content-Type"];
    [self.requestSerializer setValue:@"doAction"forHTTPHeaderField:@"te_method"];
    [self.requestSerializer setValue:@"1.0"forHTTPHeaderField:@"te_version"];
    [self.requestSerializer setValue:@"moa"forHTTPHeaderField:@"party_id"];
    self.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", @"DELETE",@"POST", nil];
    
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",nil];
    self.requestSerializer.timeoutInterval = 15;
    return self;
}


- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSMutableDictionary*)params
                 withMethodType:(int)NetworkMethod
                       andBlock:(void (^)(NSNumber *code,id data,NSString* message,NSError *error))block progressBlock:(void (^)(NSProgress *))progressBlock{
    //log请求数据
    NSLog(@"\n===========request===========\n%@:\n%@", aPath, params);
    //发起请求
    switch (NetworkMethod) {
        case Get:{
            [self GET:aPath parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                progressBlock(downloadProgress);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                block(@0,responseObject,responseObject[@"message"],nil);
                
                 NSLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                block(@1,nil,nil,error);
                
                NSLog(@"\n===========response===========\n%@:\n%@", aPath, error);
                
            }];
            break;}
        case Post:{
            [self POST:aPath parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                 progressBlock(uploadProgress);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                block(@0,responseObject,responseObject[@"message"],nil);
                
                NSLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                block(@1,nil,nil,error);
                
                NSLog(@"\n===========response===========\n%@:\n%@", aPath, error);
                
            }];
            break;
        }
        default:
            break;
    }
}
@end
