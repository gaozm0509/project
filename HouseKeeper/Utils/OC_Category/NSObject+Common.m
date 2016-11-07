//
//  NSObject+Common.m
//  IOSFramework
//
//  Created by king on 15-3-25.
//  Copyright (c) 2015年 IOSFramework. All rights reserved.
//
//
#define kPath_ImageCache @"ImageCache"
#define kPath_ResponseCache @"ResponseCache"
#define kPath_ImageSizeDict @"ImageSizeDict"

#import "NSObject+Common.h"
#import "AppDelegate.h"
#import "MBProgressHUD+Add.h"
#import "AppDelegate.h"

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
        [hud hide:YES afterDelay:1.0];
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
        hud.yOffset = kScreen_Height/2-100;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1.0];
    }
}

#pragma mark File M
//获取fileName的完整地址
- (NSString* )pathInCacheDirectory:(NSString *)fileName
{
    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cachePaths objectAtIndex:0];
    return [cachePath stringByAppendingPathComponent:fileName];
}
//创建缓存文件夹
- (BOOL) createDirInCache:(NSString *)dirName
{
    NSString *dirPath = [self pathInCacheDirectory:dirName];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:dirPath isDirectory:&isDir];
    BOOL isCreated = NO;
    if ( !(isDir == YES && existed == YES) )
    {
        isCreated = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if (existed) {
        isCreated = YES;
    }
    return isCreated;
}



// 图片缓存到本地
- (BOOL) saveImage:(UIImage *)image imageName:(NSString *)imageName
{
    if ([self createDirInCache:kPath_ImageCache]) {
        NSString * directoryPath = [self pathInCacheDirectory:kPath_ImageCache];
        BOOL isDir = NO;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL existed = [fileManager fileExistsAtPath:directoryPath isDirectory:&isDir];
        bool isSaved = false;
        if ( isDir == YES && existed == YES )
        {
            isSaved = [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:imageName] options:NSAtomicWrite error:nil];
        }
        return isSaved;
    }else{
        return NO;
    }
}
// 获取缓存图片
- (NSData*) loadImageDataWithName:( NSString *)imageName
{
    NSString * directoryPath = [self pathInCacheDirectory:kPath_ImageCache];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL dirExisted = [fileManager fileExistsAtPath:directoryPath isDirectory:&isDir];
    if ( isDir == YES && dirExisted == YES )
    {
        NSString *abslutePath = [NSString stringWithFormat:@"%@/%@", directoryPath, imageName];
        BOOL fileExisted = [fileManager fileExistsAtPath:abslutePath];
        if (!fileExisted) {
            return NULL;
        }
        NSData *imageData = [NSData dataWithContentsOfFile : abslutePath];
        return imageData;
    }
    else
    {
        return NULL;
    }
}

// 删除图片缓存
- (BOOL) deleteImageCache{
    return [self deleteCacheWithPath:kPath_ImageCache];
}

//
////网络请求
//- (BOOL)saveResponseData:(NSDictionary *)data toPath:(NSString *)requestPath{
//    User *loginUser = [Login curLoginUser];
//    if (!loginUser) {
//        return NO;
//    }else{
//        requestPath = [NSString stringWithFormat:@"%@_%@", loginUser.global_key, requestPath];
//    }
//    if ([self createDirInCache:kPath_ResponseCache]) {
//        NSString *abslutePath = [NSString stringWithFormat:@"%@/%@.plist", [self pathInCacheDirectory:kPath_ResponseCache], [requestPath md5Str]];
//        return [data writeToFile:abslutePath atomically:YES];
//    }else{
//        return NO;
//    }
//}
//- (id) loadResponseWithPath:(NSString *)requestPath{//返回一个NSDictionary类型的json数据
//    User *loginUser = [Login curLoginUser];
//    if (!loginUser) {
//        return nil;
//    }else{
//        requestPath = [NSString stringWithFormat:@"%@_%@", loginUser.global_key, requestPath];
//    }
//    NSString *abslutePath = [NSString stringWithFormat:@"%@/%@.plist", [self pathInCacheDirectory:kPath_ResponseCache], [requestPath md5Str]];
//    return [NSDictionary dictionaryWithContentsOfFile:abslutePath];
//}
- (BOOL) deleteResponseCache{
    return [self deleteCacheWithPath:kPath_ResponseCache];
}

- (BOOL) deleteCacheWithPath:(NSString *)cachePath{
    NSString *dirPath = [self pathInCacheDirectory:cachePath];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:dirPath isDirectory:&isDir];
    bool isDeleted = false;
    if ( isDir == YES && existed == YES )
    {
        isDeleted = [fileManager removeItemAtPath:dirPath error:nil];
    }
    return isDeleted;
}

//存放图片尺寸的plist管理
- (BOOL)saveImageSizeDict:(NSDictionary *)dict{
    if ([self createDirInCache:kPath_ImageSizeDict]) {
        NSString *abslutePath = [NSString stringWithFormat:@"%@/%@.plist", [self pathInCacheDirectory:kPath_ImageSizeDict], kPath_ImageSizeDict];
        return [dict writeToFile:abslutePath atomically:YES];
    }else{
        return NO;
    }
}
- (NSMutableDictionary *)loadImageSizeDict{
    NSString *abslutePath = [NSString stringWithFormat:@"%@/%@.plist", [self pathInCacheDirectory:kPath_ImageSizeDict], kPath_ImageSizeDict];
    return [NSMutableDictionary dictionaryWithContentsOfFile:abslutePath];
}

//尺寸调整
- (CGSize)sizeWithImageH_W:(CGFloat)height_width originalWidth:(CGFloat)originalWidth{
    CGSize reSize = CGSizeZero;
    reSize.width = originalWidth;
    reSize.height = originalWidth *height_width;
    return reSize;
}



- (void)refreshStatusBar{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

//- (void)loginOutToLoginVC{
////    [Login doLogout];
//    [((AppDelegate *)[UIApplication sharedApplication].delegate) setupLoginViewController];
//}

//-(id)handleResponse:(id)responseJSON{
//    NSError *error = nil;
//    //code为非0值时，表示有错
//    NSNumber *resultCode = [responseJSON valueForKeyPath:@"code"];
//    
//    if (resultCode.intValue != 0) {
//        error = [NSError errorWithDomain:kNetPath_caifuyun_Base code:resultCode.intValue userInfo:responseJSON];
//        [self showError:error];
//        
//        if (resultCode.intValue == 1000) {//用户未登录
//            [self loginOutToLoginVC];
//        }
//    }
//    //    数据为空时，构造error提示
//    //    id resultData = [responseJSON valueForKeyPath:@"data"];
//    //    if (!resultData) {
//    //        error = [NSError errorWithDomain:kNetPath_Code_Base code:resultCode.intValue userInfo:
//    //                          [NSDictionary dictionaryWithObject:
//    //                           [NSDictionary dictionaryWithObject:@"获取的数据为空" forKey:@"tipMsg"] forKey:@"msg"]];
//    //    }
//    return error;
//}
- (NSString *)getDateFromStamp:(NSString*)stamp type:(DateFormatters)dateFormatters{
    NSTimeInterval time=[stamp doubleValue];//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    switch (DateWithDate) {
        case DateWithTime:
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            break;
        case DateWithDate:
            [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
            break;
        case DateWithYear:
            [dateFormatter setDateFormat:@"yyyy"];
            break;
        default:
            break;
    }
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}
#pragma mark 判断每月天数
- (NSInteger)getDaysFromMonth:(NSInteger)month Year :(NSInteger)year{
    switch (month) {
        case 1:{
            return 31;
            break;
        }
        case 2:{
            if (year%4==0) {
                return 28;
            }
            return 29;
            break;
        }
        case 3:{
            return 31;
            break;
        }
        case 4:{
            return 30;
            break;
        }
        case 5:{
            return 31;
            break;
        }
        case 6:{
            return 30;
            break;
        }
        case 7:{
            return 31;
            break;
        }
        case 8:{
            return 31;
            break;
        }
        case 9:{
            return 30;
            break;
        }
        case 10:{
            return 31;
            break;
        }
        case 11:{
            return 30;
            break;
        }
        case 12:{
            return 31;
            break;
        }
        default:
            return 0;
            break;
    }
}

- (void)showLoginViewController{
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    UINavigationController *nVC = (UINavigationController *)app.window.rootViewController;
    
    UINavigationController *pushNVc = [[UINavigationController alloc]initWithRootViewController:PUSHVC(@"LoginViewController")];
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
//        [[SDImageCache sharedImageCache] cleanDisk];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block) {
                block(YES);
            }
        });
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

@end
