//
//  DoorEntryModel.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/31.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "DoorEntryModel.h"

@implementation DoorEntryModel

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
    self.codeStr = [dict ConvertStringForKey:@"code"];
    self.id = [dict ConvertStringForKey:@"id"];
    self.name = [dict ConvertStringForKey:@"name"];
    self.price = [dict ConvertStringForKey:@"price"];
}

@end
