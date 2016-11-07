//
//  UsersManager.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/28.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseSheetView.h"
#import "StateModel.h"

@interface UsersManager : BaseSheetView

@property (nonatomic ,copy) NSString *memberId;
@property (nonatomic, strong) StateModel *stateModel;
@property (nonatomic, copy) NSString *phone;


+ (void)saveMemberId:(NSString *)memberId;
+ (NSString *)memberId;

+ (void)saveStateModel:(StateModel *)stateModel;
+ (StateModel *)stateModel;

+ (void)savePhone:(NSString *)phone;
+ (NSString *)phone;

+ (void)loginOutAndCleanUserDefaults;
@end
