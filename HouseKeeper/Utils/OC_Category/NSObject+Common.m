//
//  NSObject+Common.m
//  IOSFramework
//
//  Created by king on 15-3-25.
//  Copyright (c) 2015年 IOSFramework. All rights reserved.
//
//

#import "NSObject+Common.h"
#import "MBProgressHUD+Add.h"
#import "KeychainItemWrapper.h"


@implementation NSObject (Common)

#pragma mark Tip M
- (NSString *)tipFromError:(NSError *)error{
    if (error && error.userInfo) {
        NSMutableString *tipStr = [[NSMutableString alloc] init];
        if ([error.userInfo objectForKey:@"msg"]) {
            NSArray *msgArray = [[error.userInfo objectForKey:@"msg"] allValues];
            NSUInteger num = [msgArray count];
            for (int i = 0; i < num; i++) {
                NSString *msgStr = [msgArray objectAtIndex:i];
                if (i+1 < num) {
                    [tipStr appendString:[NSString stringWithFormat:@"%@\n", msgStr]];
                }else{
                    [tipStr appendString:msgStr];
                }
            }
        }else{
            if ([error.userInfo objectForKey:@"NSLocalizedDescription"]) {
                tipStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
            }else{
                [tipStr appendFormat:@"ErrorCode%ld", (long)error.code];
            }
        }
        return tipStr;
    }
    return nil;
}
- (void)showError:(NSError *)error{
    NSString *tipStr = [self tipFromError:error];
    [self showHudTipStr:tipStr];
}
- (void)showHudTipStr:(NSString *)tipStr{
    if (tipStr && tipStr.length > 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] windows].lastObject animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = tipStr;
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
//        [hud hide:YES afterDelay:1.5];
        [hud hide:YES];
    }
}

- (void)showBottomTipStr:(NSString *)tipStr
{
    if(tipStr && tipStr.length > 0){
         MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] windows].lastObject  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = tipStr;
        hud.margin = 10.f;
        hud.labelFont = [UIFont systemFontOfSize:17];
        hud.yOffset = kScreen_Height / 2 - 100;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES];
    }
}

#pragma mark File M
//获取fileName的完整地址
- (NSString* )pathInCacheDirectory:(NSString *)fileName
{
    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cachePaths objectAtIndex:0];
    return [cachePath stringByAppendingPathComponent:fileName];
}

- (void)showLoginViewController{
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    UINavigationController *nVC = (UINavigationController *)window.rootViewController;
    
    UINavigationController *pushNVc = [[UINavigationController alloc]initWithRootViewController:[NSClassFromString(@"LoginViewController") alloc]];
    [nVC presentViewController:pushNVc animated:YES completion:nil];
}

/**
 *  清除缓存
 */
- (void)clearCachingAndFinishBlock:(void (^)(BOOL isFinish))block{

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //找到缓存所存的路径
        
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES)lastObject];
        
        //要清除的文件
        NSArray *files = [[NSFileManager defaultManager]subpathsAtPath:path];//返回这个路径下的所有文件的数组
        
        for (NSString *p in files) {
            NSError *error = nil;
            NSString *cachPath = [path stringByAppendingPathComponent:p];
            if ([[NSFileManager defaultManager]fileExistsAtPath:cachPath]) {
                [[NSFileManager defaultManager]removeItemAtPath:cachPath error:&error];//删除
            }
            
        }
        [[SDImageCache sharedImageCache] clearCachingAndFinishBlock:^(BOOL isFinish) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (block) {
                    block(YES);
                }
            });
        }];
        
    });
}

- (NSString *)stringTOjson   //把字典和数组转换成json字符串
{
    if (!self) {
        return nil;
    }
    NSData* jsonData =[NSJSONSerialization dataWithJSONObject:self
                                                      options:NSJSONWritingPrettyPrinted error:nil];
    NSString *strs=[[NSString alloc] initWithData:jsonData
                                         encoding:NSUTF8StringEncoding];
    return strs;
}


#pragma mark 判断是否是第一次打开
- (BOOL)isFirstOpen{
    // 取出当前软件版本号
    NSString *curVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    // 取出上次手动存储的版本号
    NSString *oldVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"VersionKey"];
    
    // 比对当前软件是否第一次打开
    if (![curVersion isEqual:oldVersion]){
        [[NSUserDefaults standardUserDefaults] setValue:curVersion forKey:@"VersionKey"];
        return YES;
    } else {
        return NO;
    }
}

- (NSString *)getUDID{
    //获取
    KeychainItemWrapper *keychain=[[KeychainItemWrapper alloc] initWithIdentifier:kImeiCode accessGroup:nil];
    NSString *imeiCode = [keychain objectForKey:(id)kSecAttrService];
    
    //设置
    if (imeiCode.length == 0) {
        imeiCode = [[NSUUID UUID] UUIDString];
        [keychain setObject:imeiCode forKey:(id)kSecAttrService];
    }
    return imeiCode;
}

@end
