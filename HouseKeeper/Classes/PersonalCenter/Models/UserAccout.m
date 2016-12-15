//
//  UserAccout.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/12.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "UserAccout.h"

@implementation UserAccout

-(id)initWithDictionary:(NSDictionary*)dict {
    if (dict == nil) {
        return nil;
    }
    if (self=[super init]) {
        [self mappingSelfProperty:dict];
    }
    return self;
}

- (void)mappingSelfProperty:(NSDictionary *)dict{
    [super mappingSelfProperty:dict];
    self.avatar = [dict ConvertStringForKey:@"avatar"];
    self.b_birth = [dict ConvertStringForKey:@"b_birth"];
    self.b_gender = [dict ConvertStringForKey:@"b_gender"];
    self.b_mobile = [dict ConvertStringForKey:@"b_mobile"];
    self.b_name = [dict ConvertStringForKey:@"b_name"];
    self.balance = [dict ConvertStringForKey:@"balance"];
    self.birth = [dict ConvertStringForKey:@"birth"];
    self.created_at = [dict ConvertStringForKey:@"created_at"];
    self.deleted_at = [dict ConvertStringForKey:@"deleted_at"];
    self.gender = [dict ConvertStringForKey:@"gender"];
    self.id = [dict ConvertStringForKey:@"id"];
    self.mobile = [dict ConvertStringForKey:@"mobile"];
    self.name = [dict ConvertStringForKey:@"name"];
    self.nickname = [dict ConvertStringForKey:@"nickname"];
    self.third_part_no = [dict ConvertStringForKey:@"third_part_no"];
    self.updated_at = [dict ConvertStringForKey:@"updated_at"];
    self.rights = [dict ConvertStringForKey:@"rights"];
}

@end
