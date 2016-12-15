//
//  CouponModel.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/12/4.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "CouponModel.h"

@implementation CouponModel
- (instancetype)initWithDic:(NSDictionary *)dic{
    if (dic == nil) {
        return nil;
    }
    if (self=[super init]) {
        [self mappingSelfProperty:dic];
    }
    return self;
}

/**
 amount = 10;
 "created_at" = "<null>";
 "deleted_at" = "<null>";
 description = "\U5723\U8bde\U8282\U4f18\U60e0\U5238";
 "expire_date" = "2016-12-31";
 id = 1;
 "limit_amount" = 15;
 "member_id" = 6;
 "updated_at" = "<null>";
 "use_date" = "<null>";
 */
- (void)mappingSelfProperty:(NSDictionary *)dict{
    [super mappingSelfProperty:dict];
    self.amount = [dict ConvertStringForKey:@"amount"];
    self.created_at = [dict ConvertStringForKey:@"created_at"];
    self.deleted_at = [dict ConvertStringForKey:@"deleted_at"];
    self.couponDescription = [dict ConvertStringForKey:@"description"];
    self.expire_date = [dict ConvertStringForKey:@"expire_date"];
    self.id = [dict ConvertStringForKey:@"id"];
    self.limit_amount = [dict ConvertStringForKey:@"limit_amount"];
    self.member_id = [dict ConvertStringForKey:@"member_id"];
    self.updated_at = [dict ConvertStringForKey:@"updated_at"];
    self.use_date = [dict ConvertStringForKey:@"use_date"];
}
@end

@implementation CouponListModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    if (dic == nil) {
        return nil;
    }
    if (self=[super init]) {
        [self mappingSelfProperty:dic];
    }
    return self;
}

- (void)mappingSelfProperty:(NSDictionary *)dict{
    [super mappingSelfProperty:dict];
    self.dataList = [[self dictionaryToArray:dict key:@"data" targetClass:@"CouponModel"] mutableCopy];
}

@end
