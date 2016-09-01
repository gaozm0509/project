//
//  PUSHPAGE.m
//  BoqiiMall
//
//  Created by ysw on 15-7-24.
//  Copyright (c) 2015年 BQ. All rights reserved.
//

#import "PUSHPAGE.h"

@implementation PUSHPAGE

+ (PUSHPAGE *)share {
    static dispatch_once_t pred;
    __strong static PUSHPAGE * sharedpush = nil;
    dispatch_once( &pred, ^{
        sharedpush = [[self alloc] init];
    });
    return sharedpush;
}

+ (PUSHPAGE *) init:(NSString *) vcname {
    return [[PUSHPAGE share] init:vcname];
}

+ (PUSHPAGE *) init:(NSString *) vcname pms:(__kindof NSDictionary *) params {
    return [[PUSHPAGE share] init:vcname pms:params];
}

- (PUSHPAGE *) init:(NSString *) vcname{
    return [self init:vcname nib:NO tabbar:YES needdelegate:NO pms:nil];
}

- (PUSHPAGE *) init:(NSString *) vcname nib:(BOOL) isnib{
    return [self init:vcname nib:isnib tabbar:YES needdelegate:NO pms:nil];
}

- (PUSHPAGE *) init:(NSString *) vcname pms:(__kindof NSDictionary *) params{
    return [self init:vcname nib:NO tabbar:YES needdelegate:NO pms:params];
}

- (PUSHPAGE *) init:(NSString *) vcname nib:(BOOL) isnib pms:(__kindof NSDictionary *) params{
    return [self init:vcname nib:isnib tabbar:YES needdelegate:NO pms:params];
}

- (PUSHPAGE *)init:(NSString *) vcname nib:(BOOL) isnib tabbar:(BOOL) hidetab needdelegate:(BOOL) noneed pms:(__kindof NSDictionary *) params{
    if (self = [super init]) {
        [PUSHPAGE share].VCNAME = vcname;
        [PUSHPAGE share].ISNIB = isnib;
        [PUSHPAGE share].HIDETABBAR = hidetab;
        [PUSHPAGE share].ISNEEDDELEGAGE = noneed;
        [PUSHPAGE share].PARAMS = params;
    }
    
    return  self;
}
@end
