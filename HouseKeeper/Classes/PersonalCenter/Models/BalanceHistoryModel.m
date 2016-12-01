//
//  BalanceHistoryModel.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/11/25.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BalanceHistoryModel.h"

@implementation BalanceHistoryModel

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
    self.created_at = [dict ConvertStringForKey:@"created_at"];
    self.deleted_at = [dict ConvertStringForKey:@"deleted_at"];
    self._description = [dict ConvertStringForKey:@"description"];
    self.id = [dict ConvertStringForKey:@"id"];
    self.member_id = [dict ConvertStringForKey:@"member_id"];
}

@end

@implementation BalanceHistoryListModel

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
    self.dataList = [[self dictionaryToArray:dict key:@"data" targetClass:@"BalanceHistoryModel"] mutableCopy];
}

@end
