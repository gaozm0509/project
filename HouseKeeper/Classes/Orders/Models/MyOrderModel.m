//
//  MyOrderModel.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/11/6.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "MyOrderModel.h"

@implementation MyOrderModel

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
    self.id = [dict ConvertStringForKey:@"id"];
    self.amount = [dict ConvertStringForKey:@"amount"];
    self.coupon_id = [dict ConvertStringForKey:@"coupon_id"];
    self.furniture_id = [dict ConvertStringForKey:@"furniture_id"];
    self.member_id = [dict ConvertStringForKey:@"member_id"];
    self.order_date = [dict ConvertStringForKey:@"order_date"];
    self.pay_info = [dict ConvertStringForKey:@"pay_info"];
    self.server = [dict ConvertStringForKey:@"server"];
    self.server_date = [dict ConvertStringForKey:@"server_date"];
    self.server_details = [dict ConvertStringForKey:@"server_details"];
    self.server_id = [dict ConvertStringForKey:@"server_id"];
    self.server_point = [dict ConvertStringForKey:@"server_point"];
    self.service_id = [dict ConvertStringForKey:@"service_id"];
    self.state_id = [dict ConvertStringForKey:@"state_id"];
    self.status = [[dict ConvertStringForKey:@"status"] integerValue];
    self.type = [dict ConvertStringForKey:@"type"];
    self.created_at = [dict ConvertStringForKey:@"created_at"];
    
}


@end

@implementation MyOrderListModel
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
    self.pageModel = [[PageModel alloc] initWithDic:dict];
    self.orderList = [[self dictionaryToArray:dict key:@"data" targetClass:@"MyOrderModel"] mutableCopy];
    
}


@end
