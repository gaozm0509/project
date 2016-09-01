//
//  BaseResponse.h
//  BoqiiMall
//
//  Created by ysw on 15-7-23.
//  Copyright (c) 2015年 BQ. All rights reserved.
//

#import "BaseModel.h"

@interface BaseResponse : BaseModel
//@property (assign,nonatomic) NSInteger ResponseStatus;
//@property (strong,nonatomic) NSString * ResponseMsg;

-(instancetype)initWithDic:(NSDictionary*)dic;

- (instancetype) initWithDictionary:(NSDictionary*)dict;

- (instancetype) initWithDictionary:(NSDictionary*)dict error:(NSError**)err;

- (NSArray *) dictionaryToArray:(id) __dictionary__ key:(NSString*) __skey__ targetClass:(NSString*) __class__;
@end
