//
//  MyOrderModel.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/11/6.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseModel.h"

typedef NS_ENUM(NSInteger, OrderType) {
    OrderTypeToBePaid = 1,     //待支付
    OrderTypeCompletedPaid,//已支付
    OrderTypeArrange,      //安排中
    OrderTypeServering,    //服务中
    OrderTypeCompletedAll, //已完成
    OrderTypeAll = 0,           //全部
    OrderTypeCancle = 99, //已取消
};

@interface MyOrderModel : BaseModel

@property (nonatomic ,copy) NSString *id;
@property (nonatomic ,copy) NSString *amount;
@property (nonatomic ,copy) NSString *coupon_id;
@property (nonatomic, copy) NSString *furniture_id;
@property (nonatomic, copy) NSString *member_id;
@property (nonatomic, copy) NSString *order_date;
@property (nonatomic, copy) NSString *pay_info;
@property (nonatomic, copy) NSString *server;
@property (nonatomic, copy) NSString *server_date;
@property (nonatomic, copy) NSString *server_details;
@property (nonatomic, copy) NSString *server_id;
@property (nonatomic, copy) NSString *server_point;
@property (nonatomic, copy) NSString *service_id;
@property (nonatomic, copy) NSString *state_id;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, assign) OrderType status;
@property (nonatomic, copy) NSString *type;



@end

@interface MyOrderListModel : BaseModel

@property (nonatomic, strong) PageModel *pageModel;
@property (nonatomic, strong) NSMutableArray<MyOrderModel *> *orderList;

@end
