//
//  NSString+NetRequest.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/9/7.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "NSString+NetRequest.h"
#import "KeychainItemWrapper.h"
#import "MBProgressHUD+Add.h"

@implementation NSString (NetRequest)

- (void)httpRequestWithParams:(NSMutableDictionary *)params networkMethod:(NetworkMethod)method andBlock:(void (^)(id, NSError *))block{
    
    //添加imei
    KeychainItemWrapper *keychain=[[KeychainItemWrapper alloc] initWithIdentifier:kImeiCode accessGroup:nil];
    NSString *imeiCode = [keychain  objectForKey:(id)kSecAttrService];
    [params setValue:imeiCode forKey:@"imei"];
    
    //添加hud
    [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];
    
    [[HKAFHTTPSessionManager sharedJsonClient]requestJsonDataWithPath:self withParams:params withMethodType:method andBlock:^(NSNumber *code, id data, NSString *message, NSError *error) {
        
        //删除hud
        [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication].delegate window] animated:YES];
        
        if (data) {
            block(data, nil);
        }else{
            block(message, error);
        }
    } progressBlock:^(NSProgress *downloadProgress) {
        
    }];
}
@end