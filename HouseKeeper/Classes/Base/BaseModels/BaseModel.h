//
//  BaseModel.h
//  BoqiiMall
//
//  Created by ysw on 15-7-23.
//  Copyright (c) 2015年 BQ. All rights reserved.
//
 
@class metadata;
@interface BaseModel : NSObject
@property(nonatomic,assign)NSInteger ResponseStatus;
@property(nonatomic,strong)NSString *ResponseMsg;
@property(nonatomic,strong)metadata *metadata;

-(instancetype)initWithDic:(NSDictionary*)dic;

-(id)initWithDictionary:(NSDictionary*)dict;

- (id) initWithDictionary:(NSDictionary*)dict error:(NSError**)err;

- (NSMutableArray *) dictionaryToArray:(id) __dictionary__ key:(NSString*) __skey__ targetClass:(NSString*) __class__ ;

- (void) mappingSelfProperty:(NSDictionary*) dict;
@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////
@protocol metadata @end
@interface metadata : BaseModel

@property(nonatomic,assign)NSInteger totalPages;
@property(nonatomic,assign)NSInteger currentPage;
@property(nonatomic,assign)NSInteger perPage;
@property(nonatomic,assign)NSInteger count;

@end
