//
//  AppDelegate.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/16.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TabBarViewController.h"
#import <AFNetworkActivityIndicatorManager.h>
#import "KeychainItemWrapper.h"
#import "WXApi.h"
#import "NewFeaturesViewController.h"
#import <JSPatchPlatform/JSPatch.h>

@interface AppDelegate () <UISplitViewControllerDelegate,WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    if ([self isFirstOpen]) {
        NewFeaturesViewController *VC = [[NewFeaturesViewController alloc]init];
        self.window.rootViewController = VC;
    }else{
        if ([UsersManager memberId].length > 0) {
            TabBarViewController *rootVC = [[TabBarViewController alloc]init];
            self.window.rootViewController = rootVC;
        }
        else{
            LoginViewController *rootVC = [[LoginViewController alloc]init];
            self.window.rootViewController = rootVC;
            rootVC.isFirstStartUp = YES;
        }
    }
    
    
    
    [self.window makeKeyAndVisible];
    
    [[AFNetworkActivityIndicatorManager sharedManager]setEnabled:YES];
    
    
    //设置NavBar
    [self customizeInterface];
    [self setImeiCode];
    
    if ([WXApi registerApp:kWXAppId withDescription:nil]) {
        NSLog(@"wechat regist success");
    };
    
    //启动页停留
    [NSThread sleepForTimeInterval:1.5];
    
    //JSPatch
    [JSPatch startWithAppKey:JSPatchKey];
    [JSPatch sync];
    
    [self setUpForDismissKeyboard];
    
    return YES;
    
}


/**
 *  设置uuid存入到KeychainItemWrapper中充当imei code
 */
- (void)setImeiCode{
    KeychainItemWrapper *keychain=[[KeychainItemWrapper alloc] initWithIdentifier:kImeiCode accessGroup:nil];
    NSString *devicNum = [keychain  objectForKey:(id)kSecAttrService];
    if (devicNum==nil) {
        devicNum = [[NSUUID UUID] UUIDString];
        [keychain setObject:devicNum forKey:(id)kSecAttrService];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//9.0后的方法
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    //这里判断是否发起的请求为微信支付，如果是的话，用WXApi的方法调起微信客户端的支付页面（://pay 之前的那串字符串就是你的APPID，）
    return  [WXApi handleOpenURL:url delegate:self];
}

#pragma mark - WXApiDelegate
// 微信支付结果回调方法
- (void)onResp:(BaseResp *)resp {
    NSString *payResoult = [NSString stringWithFormat:@"%d", resp.errCode];
    
    if([resp isKindOfClass:[PayResp class]]){
        
        /**
         WXSuccess           = 0,     成功
         WXErrCodeCommon     = -1,    普通错误类型
         WXErrCodeUserCancel = -2,    用户点击取消并返回
         WXErrCodeSentFail   = -3,    发送失败
         WXErrCodeAuthDeny   = -4,    授权失败
         WXErrCodeUnsupport  = -5,    微信不支持
         */
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode) {
            case WXSuccess:
                payResoult = @"支付成功";
                break;
            case WXErrCodeCommon:
                payResoult = @"支付失败";
                break;
            case WXErrCodeUserCancel:
                payResoult = @"用户点击取消并返回";
                break;
            default:
                // 错误码 以及 错误提示字符串
                payResoult = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                break;
        }
        [self showHudTipStr:payResoult];
    }
}

#pragma mark  键盘隐藏
- (void)setUpForDismissKeyboard {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapAnywhereToDismissKeyboard:)];
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    WS(weakSelf);
    [nc addObserverForName:UIKeyboardWillShowNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [weakSelf.window addGestureRecognizer:singleTapGR];
                }];
    [nc addObserverForName:UIKeyboardWillHideNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [weakSelf.window removeGestureRecognizer:singleTapGR];
                }];
}
- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里所有的subview的first responder都resign掉
    [self.window endEditing:YES];
}

#pragma mark - Split view

- (void)customizeInterface {
    //设置Nav的背景色和title色
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    NSDictionary *textAttributes = nil;
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        [navigationBarAppearance setTintColor:[UIColor whiteColor]];//返回按钮的箭头颜色
        [[UITextField appearance] setTintColor:KMajorColor];//设置UITextField的光标颜色
        [[UITextView appearance] setTintColor:KMajorColor];//设置UITextView的光标颜色
        [[UIBarButtonItem appearance]setTintColor:KMajorColor];
        
        textAttributes = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:kNavTitleFontSize],
                           NSForegroundColorAttributeName: KMajorColor,
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        [[UISearchBar appearance] setBackgroundImage:[UIImage imageWithColor:KMajorColor]];
        
        textAttributes = @{
                           UITextAttributeFont: [UIFont boldSystemFontOfSize:kNavTitleFontSize],
                           UITextAttributeTextColor: [UIColor whiteColor],
                           UITextAttributeTextShadowColor: [UIColor clearColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    [navigationBarAppearance setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
    [navigationBarAppearance setShadowImage:[UIImage imageWithColor:KMajorColor]];
}

@end
