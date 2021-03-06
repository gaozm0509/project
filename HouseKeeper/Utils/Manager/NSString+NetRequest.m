//
//  NSString+NetRequest.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/9/7.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "NSString+NetRequest.h"
#import "KeychainItemWrapper.h"


@implementation NSString (NetRequest)

- (void)httpRequestWithParams:(NSMutableDictionary *)params networkMethod:(NetworkMethod)method andBlock:(void (^)(id, NSError *))block{
    
    //添加imei
    KeychainItemWrapper *keychain=[[KeychainItemWrapper alloc] initWithIdentifier:kImeiCode accessGroup:nil];
    NSString *imeiCode = [keychain  objectForKey:(id)kSecAttrService];
    if (!params) {
        params = [NSMutableDictionary dictionary];
    }
    [params setValue:imeiCode forKey:@"imei"];
    [params setValue:[UsersManager memberId] forKey:@"member_id"];
    [params setValue:[UsersManager rights] forKey:@"rights"];
    
    
    //如果是第二联系人，只能操作订单模块
    if ([params[@"rights"] isEqualToString:@"0"]) {
        if ([self isEqualToString:kApi_member_update]) {
            
            [MBProgressHUD hideAllHUDsForView:[[UIApplication sharedApplication].delegate window] animated:YES];
            [self showHudTipStr:@"您没有权限操作"];
            return;
        }
    }
    
    //添加hud
    [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];
    
    [[HKAFHTTPSessionManager sharedJsonClient]requestJsonDataWithPath:self withParams:params withMethodType:method andBlock:^(NSNumber *code, id data, NSString *message, NSError *error) {
        
        //删除hud
        [MBProgressHUD hideAllHUDsForView:[[UIApplication sharedApplication].delegate window] animated:YES];
        
        if (data) {
            block(data, nil);
            if ([data[@"code"] integerValue] == 0) {
                [self showHudTipStr:data[@"message"]];
            }
            if ([data[@"code"] integerValue] == 2) {
                [self showLoginViewController];
                [self showHudTipStr:@"系统检测到您在其他设备上登录，请重新登录"];
            }
        }else{
            block(message, error);
        }
    } progressBlock:^(NSProgress *downloadProgress) {
        
    }];
}

- (void)httpRequestWithParams:(NSMutableDictionary *)params hudView:(MBProgressHUD *)hueView networkMethod:(NetworkMethod)method andBlock:(void (^)(id, NSError *))block{
    
    if (!params) {
        params = [NSMutableDictionary dictionary];
    }
    
    //如果是第二联系人，只能操作订单模块
    if ([params[@"rights"] isEqualToString:@"0"]) {
        if ([self isEqualToString:kApi_member_update]) {
            [self showHudTipStr:@"您没有权限操作"];
            [hueView hide:NO];
            return;
        }
    }
    
    [self httpRequestWithParams:params networkMethod:method isShowHud:NO andBlock:^(id data, NSError *error) {
        [hueView hide:YES];
        block(data,error);
    }];
}

- (void)httpRequestWithParams:(NSMutableDictionary *)params networkMethod:(NetworkMethod)method isShowHud:(BOOL)isShowHud andBlock:(void (^)(id, NSError *))block{
    
    //添加imei
    KeychainItemWrapper *keychain=[[KeychainItemWrapper alloc] initWithIdentifier:kImeiCode accessGroup:nil];
    NSString *imeiCode = [keychain  objectForKey:(id)kSecAttrService];
    [params setValue:imeiCode forKey:@"imei"];
    [params setValue:[UsersManager memberId] forKey:@"member_id"];
    [params setValue:[UsersManager rights] forKey:@"rights"];
    
    //添加hud
    if (isShowHud) {
        [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];
    }
    
    //如果是第二联系人，只能操作订单模块
    if ([params[@"rights"] isEqualToString:@"0"]) {
        if ([self isEqualToString:kApi_member_update]) {
            [MBProgressHUD hideAllHUDsForView:[[UIApplication sharedApplication].delegate window] animated:YES];
            [self showHudTipStr:@"您没有权限操作"];
            return;
        }
    }
    
    [[HKAFHTTPSessionManager sharedJsonClient]requestJsonDataWithPath:self withParams:params withMethodType:method andBlock:^(NSNumber *code, id data, NSString *message, NSError *error) {
        
        //删除hud
        if (isShowHud) {
            [MBProgressHUD hideHUDForView:[[UIApplication sharedApplication].delegate window] animated:YES];
        }
        
        if (data) {
            block(data, nil);
            if ([data[@"code"] integerValue] == 0) {
                [self showHudTipStr:data[@"message"]];
            }
            if ([data[@"code"] integerValue] == 2) {
                [self showLoginViewController];
                [self showHudTipStr:@"系统检测到您在其他设备上登录，请重新登录"];
            }
        }else{
            block(message, error);
        }
    } progressBlock:^(NSProgress *downloadProgress) {
        
    }];
}

- (void)uploadImageWithParams:(NSMutableDictionary *)params image:(UIImage *)image andBlock:(void (^)(id, NSError *))block progressBlock:(void (^)(CGFloat ))progressBlock{
    
    
    
    [params setValue:[UsersManager memberId] forKey:@"member_id"];
    
    [[HKAFHTTPSessionManager sharedJsonClient] uploudFileWithPath:self withParams:params withImage:image andBlock:^(NSNumber *code, id data, NSString *message, NSError *error) {
        block(data,error);
        
    } progressBlock:^(NSProgress *downloadProgress) {
        NSLog(@"%f",(float)downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        progressBlock(downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    }];
}

@end
