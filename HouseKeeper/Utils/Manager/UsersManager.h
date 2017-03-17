//
//  UsersManager.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/28.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "StateModel.h"

@interface UsersManager : NSObject

@property (nonatomic ,copy) NSString *memberId;
@property (nonatomic, strong) StateModel *stateModel;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *rights;
@property (nonatomic, copy) NSString *name;


+ (void)saveMemberId:(NSString *)memberId;
+ (NSString *)memberId;

+ (void)saveStateModel:(StateModel *)stateModel;
+ (StateModel *)stateModel;

+ (void)savePhone:(NSString *)phone;
+ (NSString *)phone;

+ (void)saveRights:(NSString *)rights;//是否是第二联系人
+ (NSString *)rights;

+ (void)saveName:(NSString *)name;
+ (NSString *)name;

+ (void)loginOutAndCleanUserDefaults;
@end
