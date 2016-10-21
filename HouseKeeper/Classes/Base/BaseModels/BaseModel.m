//
//  BaseModel.m
//  BoqiiMall
//
//  Created by ysw on 15-7-23.
//  Copyright (c) 2015年 BQ. All rights reserved.
//

#import "BaseModel.h" 

@implementation metadata

-(id)initWithDictionary:(NSDictionary*)dict error:(NSError**)err {
    if (self=[super initWithDictionary:dict error:err]) {
        [self mappingSelfProperty:dict];
    }
    return self;
}

-(instancetype)initWithDic:(NSDictionary*)dic {
    if (self=[super initWithDic:dic]) {
        [self mappingSelfProperty:dic];
    }
    return self;
}

#pragma mark    --  private method
- (void) mappingSelfProperty:(NSDictionary*) dict {
    [super mappingSelfProperty:dict];
    self.totalPages  = [[dict ConvertStringForKey:@"totalPages"] integerValue];
    self.currentPage  = [[dict ConvertStringForKey:@"currentPage"] integerValue];
    self.perPage  = [[dict ConvertStringForKey:@"perPage"] integerValue];
    self.count  = [[dict ConvertStringForKey:@"count"] integerValue];
}

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation BaseModel
@synthesize code;
@synthesize message;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (dic == nil) {
        return nil;
    }
    if (self=[super init]) {
        [self mappingSelfProperty:dic];
    }
    return self;
}

-(id)initWithDictionary:(NSDictionary*)dict {
    if (dict == nil) {
        return nil;
    }
    if (self=[super init]) {
        [self mappingSelfProperty:dict];
    }
    return self;
}

- (id) initWithDictionary:(NSDictionary*)dict error:(NSError**)err
{
    if (dict == nil) {
        return nil;
    }
    if (self=[super init]) {
        [self mappingSelfProperty:dict];
    }
    return self;
}

- (NSArray *) dictionaryToArray:(id) __dictionary__ key:(NSString*) __skey__ targetClass:(NSString*) __class__{
    
    if ( __dictionary__ == nil
        || __dictionary__ == NULL
        || ![__dictionary__ isKindOfClass:[NSDictionary class]]) {
        return [NSArray array];
    }
    
    if ( __skey__ == nil
        || __skey__.length==0) {
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

- (void) mappingSelfProperty:(NSDictionary*) dict
{
    self.code = [[dict ConvertStringForKey:@"code"] integerValue];
    self.message = [dict ConvertStringForKey:@"message"];
}
@end
