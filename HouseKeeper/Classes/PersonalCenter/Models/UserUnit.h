//
//  UserUnit.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/10.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserUnit : NSObject

@property (nonatomic, strong) NSString *userId;
@property (nonatomic ,strong) NSString *userName;
@property (nonatomic, strong) NSString *userPhone;

//+ (void)saveUserId:(NSString *)userId;
//+ (void)saveUserName:(NSString *)userName;
//+ (void)saveUserPhone:(NSArray *)userPhone;

//+ (void)logOut;

@end
