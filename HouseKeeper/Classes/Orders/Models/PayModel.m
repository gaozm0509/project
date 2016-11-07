//
//  OrderModel.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/11/5.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "PayModel.h"

@implementation PayModel
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
    self.amount = [dict ConvertStringForKey:@"amount"];
    self.furniture_id = [dict ConvertStringForKey:@"furniture_id"];
    self.id = [dict ConvertStringForKey:@"id"];
    self.state_id = [dict ConvertStringForKey:@"state_id"];
    self.id = [dict ConvertStringForKey:@"id"];
    self.type = [dict ConvertStringForKey:@"type"];
    self.member_id = [dict ConvertStringForKey:@"member_id"];
    self.order_date = [[PayDateModel alloc] initWithDic:[dict ConvertDictForKey:@"order_date"]];
}
@end

@implementation PayDateModel

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
    self.date = [dict ConvertStringForKey:@"date"];
    self.timezone = [dict ConvertStringForKey:@"timezone"];
    self.timezone_type = [dict ConvertStringForKey:@"timezone_type"];
}
@end
