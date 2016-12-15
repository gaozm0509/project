//
//  UserAccout.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/12.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseModel.h"

@interface UserAccout : BaseModel

@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *b_birth;
@property (nonatomic, copy) NSString *b_gender;
@property (nonatomic, copy) NSString *b_mobile;
@property (nonatomic ,copy) NSString *b_name;
@property (nonatomic, copy) NSString *balance;
@property (nonatomic, copy) NSString *birth;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *deleted_at;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *third_part_no;
@property (nonatomic, copy) NSString *updated_at;
@property (nonatomic, copy) NSString *rights;
//非网络请求字段
@property (nonatomic, assign) NSInteger couponNumbers;
@end
