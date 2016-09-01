//
//  BaseResponse.m
//  BoqiiMall
//
//  Created by ysw on 15-7-23.
//  Copyright (c) 2015年 BQ. All rights reserved.
//

#import "BaseResponse.h"

@implementation BaseResponse

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        [self mappingSelfProperty:dic];
    }
    return self;
}

- (instancetype) initWithDictionary:(NSDictionary*)dict
{
    if (self=[super init]) {
        [self mappingSelfProperty:dict];
    }
    return self;
}

- (instancetype) initWithDictionary:(NSDictionary*)dict error:(NSError**)err
{
    if (self=[super init]) {
        [self mappingSelfProperty:dict];
    }
    return self;
}

#pragma mark    --  private method
- (void) mappingSelfProperty:(NSDictionary*) dict {
    self.ResponseStatus = [[dict ConvertStringForKey:@"ResponseStatus"] integerValue];
    self.ResponseMsg = [dict ConvertStringForKey:@"ResponseMsg"];
}

- (NSArray *) dictionaryToArray:(id) __dictionary__ key:(NSString*) __skey__ targetClass:(NSString*) __class__{
    
    if ( __dictionary__ == nil
        || __dictionary__ == NULL
        || ![__dictionary__ isKindOfClass:[NSDictionary class]]) {
        return [NSArray array];
    }
    
    if ( __skey__ == nil
        || __skey__.length==0 || [__skey__ isEqualToString:@"<null>"] || [__skey__ isEqualToString:@"null"]) {
        return [NSArray array];
    }
    
    if ([__dictionary__ isKindOfClass:[NSDictionary class]]) {
        
        NSArray * __array__ = [__dictionary__ ConvertArrayForKey:__skey__];
        
        NSMutableArray * tmparr3 = [[NSMutableArray alloc] initWithCapacity:[(NSArray*)__array__ count]];
        for (NSDictionary * item in (NSArray*)__array__) {
            
            Class  class_Page = NSClassFromString(__class__);
            
            if (class_Page) {
                if ([class_Page respondsToSelector:NSSelectorFromString(@"initWithDic:")]) {
                    [tmparr3 addObject:[[class_Page alloc] initWithDic:item]];
                }
                else {
                    [tmparr3 addObject:[[class_Page alloc] initWithDictionary:item  error:nil]];
                }
            }
        }
        
        return tmparr3;
    }
    return [NSArray array];
}
@end
