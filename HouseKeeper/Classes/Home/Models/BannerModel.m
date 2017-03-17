//
//  BannerModel.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/12/29.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BannerModel.h"

@implementation BannerModel
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
    self.img = [dict ConvertStringForKey:@"img"];
    self.link = [dict ConvertStringForKey:@"link"];
    self.name = [dict ConvertStringForKey:@"name"];
    self.tips = [dict ConvertStringForKey:@"tips"];
    self.type = [dict ConvertStringForKey:@"type"];
}
@end

@implementation BannerListModel

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
    self.data = [[self dictionaryToArray:dict key:@"data" targetClass:@"BannerModel"] mutableCopy];
}

@end
