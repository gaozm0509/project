//
//  OrderModel.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/11/5.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseModel.h"

@interface PayDateModel : BaseModel

@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *timezone;
@property (nonatomic, copy) NSString *timezone_type;

@end

@interface PayModel : BaseModel

@property (nonatomic ,copy) NSString *amount;
@property (nonatomic ,copy) NSString *furniture_id;
@property (nonatomic ,copy) NSString *id;
@property (nonatomic ,strong) PayDateModel *order_date;
@property (nonatomic ,copy) NSString *state_id;
@property (nonatomic ,copy) NSString *type;
@property (nonatomic ,copy) NSString *member_id;

@end
