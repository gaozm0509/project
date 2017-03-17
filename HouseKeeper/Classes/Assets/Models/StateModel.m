//
//  StateModel.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/13.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "StateModel.h"

@implementation StateModel

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
    self.deleted_at = [dict ConvertStringForKey:@"deleted_at"];
    self.id = [dict ConvertStringForKey:@"id"];
    self.latitude = [dict ConvertStringForKey:@"latitude"];
    self.longitude = [dict ConvertStringForKey:@"longitude"];
    self.layout = [dict ConvertStringForKey:@"layout"];
    self.residential = [dict ConvertStringForKey:@"residential"];
    self.updated_at = [dict ConvertStringForKey:@"updated_at"];
}

@end


@implementation StateModelDataModel


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
    self.current_page = [dict ConvertStringForKey:@"current_page"];
    self.from = [dict ConvertStringForKey:@"from"];
    self.last_page = [dict ConvertStringForKey:@"last_page"];
    self.next_page_url = [dict ConvertStringForKey:@"next_page_url"];
    self.per_page = [dict ConvertStringForKey:@"per_page"];
    self.prev_page_url = [dict ConvertStringForKey:@"prev_page_url"];
    self.to = [dict ConvertStringForKey:@"to"];
    self.total = [dict ConvertStringForKey:@"total"];
    self.StateModelList = [[NSMutableArray alloc]initWithArray:[self dictionaryToArray:dict key:@"data" targetClass:@"StateModel"]];
   
}

@end


@implementation RoomType

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
    self.name = [dict ConvertStringForKey:@"name"];
}

@end


@implementation RoomTypeList

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
    self.dataList = [[self dictionaryToArray:dict key:@"data" targetClass:@"RoomType"] mutableCopy];
}

@end


@implementation OthersModel

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
    self.key = [[dict allKeys] firstObject];
    self.value = [dict ConvertStringForKey:self.key];
    
}

@end

@implementation FurnitureModel

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
    if (![dict isKindOfClass:[NSDictionary class]]) {
        return;
    }
    self.brand = [dict ConvertStringForKey:@"brand"];
    self.created_at = [dict ConvertStringForKey:@"created_at"];
    self.created_by = [dict ConvertStringForKey:@"created_by"];
    self.fimei = [dict ConvertStringForKey:@"fimei"];
    self.id = [dict ConvertStringForKey:@"id"];
    self.invoice = [dict ConvertStringForKey:@"invoice"];
    self.model = [dict ConvertStringForKey:@"model"];
    self.name = [dict ConvertStringForKey:@"name"];
    self.purchase_date = [dict ConvertStringForKey:@"purchase_date"];
    self.room_id = [dict ConvertStringForKey:@"room_id"];
    self.schedule = [dict ConvertStringForKey:@"schedule"];
    self.schedule_description = [dict ConvertStringForKey:@"schedule_description"];
    self.schedule_period = [dict ConvertStringForKey:@"schedule_period"];
    self.serial = [dict ConvertStringForKey:@"serial"];
    self.type_id = [dict ConvertStringForKey:@"type_id"];
    self.updated_at = [dict ConvertStringForKey:@"updated_at"];
    self.isMaintenanceReminder = NO;
    
    self.others = [[self dictionaryToArray:dict key:@"others" targetClass:@"OthersModel"] mutableCopy];
}

@end


@implementation RoomModel

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
    self.area = [dict ConvertStringForKey:@"area"];
    self.id = [dict ConvertStringForKey:@"id"];
    self.created_at = [dict ConvertStringForKey:@"created_at"];
    self.name = [dict ConvertStringForKey:@"name"];
    self.state_id = [dict ConvertStringForKey:@"state_id"];
    self.type_id = [dict ConvertStringForKey:@"type_id"];
    self.updated_at = [dict ConvertStringForKey:@"updated_at"];
    self.furnitures = [[self dictionaryToArray:dict key:@"furnitures" targetClass:@"FurnitureModel"] mutableCopy];
}

@end


@implementation RoomListModel

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
    self.name = [dict ConvertStringForKey:@"name"];
    self.rooms = [self dictionaryToArray:dict key:@"rooms" targetClass:@"RoomModel"];
}

@end

@implementation RoomClassModel

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
    self.roomClasses = [[self dictionaryToArray:dict key:@"data" targetClass:@"RoomListModel"] mutableCopy];
}

@end
