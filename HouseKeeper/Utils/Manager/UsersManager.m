//
//  UsersManager.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/28.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "UsersManager.h"

#define kUsersManager_memberId @"kUsersManager_memberId"
#define kUsersManager_stateModel @"kUsersManager_stateModel"
#define kUsersManager_phone @"kUsersManager_phone"
#define kUsersManager_rights @"kUsersManager_rights"

@implementation UsersManager

+ (UsersManager *)sharedUsersManager {
    static UsersManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[UsersManager alloc] init];
    });
    [_sharedClient initData];
    return _sharedClient;
}

- (void)initData{
    self.memberId = GetUserDefaults(kUsersManager_memberId);
    self.phone = GetUserDefaults(kUsersManager_phone);
    self.stateModel = [[StateModel alloc] initWithDic:GetUserDefaults(kUsersManager_stateModel)];
    self.rights = GetUserDefaults(kUsersManager_rights);
}

+ (void)saveMemberId:(NSString *)memberId{
    SetUserDefaults(memberId, kUsersManager_memberId);
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [UsersManager sharedUsersManager].memberId = memberId;
}

+ (NSString *)memberId{
    return [UsersManager sharedUsersManager].memberId;
}

+ (void)saveStateModel:(StateModel *)stateModel{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:stateModel.id forKey:@"id"];
    [params setValue:stateModel.address forKey:@"address"];
    [params setValue:stateModel.area forKey:@"area"];
    [params setValue:stateModel.layout forKey:@"layout"];
    [params setValue:stateModel.residential forKey:@"residential"];
    
    SetUserDefaults(params, kUsersManager_stateModel);
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [UsersManager sharedUsersManager].stateModel = stateModel;
}

+ (StateModel *)stateModel{
    return [UsersManager sharedUsersManager].stateModel;
}

+ (void)savePhone:(NSString *)phone{
    SetUserDefaults(phone, kUsersManager_phone);
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [UsersManager sharedUsersManager].phone = phone;
}

+ (NSString *)phone{
    return [UsersManager sharedUsersManager].phone;
}

+ (void)saveRights:(NSString *)rights{
    SetUserDefaults(rights, kUsersManager_rights);
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [UsersManager sharedUsersManager].rights = rights;
}

+ (NSString *)rights{
    return [UsersManager sharedUsersManager].rights;
}

+ (void)loginOutAndCleanUserDefaults{
    SetUserDefaults(nil, kUsersManager_memberId);
    SetUserDefaults(nil, kUsersManager_stateModel);
    SetUserDefaults(nil, kUsersManager_rights);
    
    [UsersManager sharedUsersManager].memberId = nil;
    [UsersManager sharedUsersManager].rights = nil;
    [UsersManager sharedUsersManager].stateModel = nil;
}

@end
