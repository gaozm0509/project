//
//  CouponModel.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/12/4.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseModel.h"


/**
 amount = 10;
 "created_at" = "<null>";
 "deleted_at" = "<null>";
 description = "\U5723\U8bde\U8282\U4f18\U60e0\U5238";
 "expire_date" = "2016-12-31";
 id = 1;
 "limit_amount" = 15;
 "member_id" = 6;
 "updated_at" = "<null>";
 "use_date" = "<null>";
 */
@interface CouponModel : BaseModel

@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *deleted_at;
@property (nonatomic, copy) NSString *couponDescription;
@property (nonatomic, copy) NSString *expire_date;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *limit_amount;
@property (nonatomic, copy) NSString *member_id;
@property (nonatomic, copy) NSString *updated_at;
@property (nonatomic, copy) NSString *use_date;

@end

@interface CouponListModel : BaseModel

@property (nonatomic, strong) NSMutableArray *dataList;

@end
