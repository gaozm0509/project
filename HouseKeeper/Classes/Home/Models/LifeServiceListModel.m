//
//  LifeServiceListModel.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/11/24.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "LifeServiceListModel.h"

@implementation LifeServiceListModel

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
    self.address = [dict ConvertStringForKey:@"address"];
    self.area = [dict ConvertStringForKey:@"area"];
    self.created_at = [dict ConvertStringForKey:@"created_at"];
    self._description = [dict ConvertStringForKey:@"description"];
    self.id = [dict ConvertStringForKey:@"id"];
    self.image_url = [dict ConvertStringForKey:@"image_url"];
    self.latitude = [dict ConvertStringForKey:@"latitude"];
    self.longitude = [dict ConvertStringForKey:@"longitude"];
    self.points = [dict ConvertStringForKey:@"points"];
    self.telephone = [dict ConvertStringForKey:@"telephone"];
    self.title = [dict ConvertStringForKey:@"title"];
    self.type_id = [dict ConvertStringForKey:@"type_id"];
}

@end

@implementation LifeServiceListDataModel

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
    self.dataList = [[self dictionaryToArray:dict key:@"data" targetClass:@"LifeServiceListModel"] mutableCopy];
}

@end

