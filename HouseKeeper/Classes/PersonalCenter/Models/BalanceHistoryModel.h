//
//  BalanceHistoryModel.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/11/25.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseModel.h"

/**
 amount = "-0.01";
 "created_at" = "2016-10-25 12:48:05";
 "deleted_at" = "<null>";
 description = "2-\U652f\U4ed8\U8ba2\U5355{8}";
 id = 15;
 "member_id" = 2;
 "updated_at" = "2016-10-25 13:52:16";
 */
@interface BalanceHistoryModel : BaseModel

@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *deleted_at;
@property (nonatomic, copy) NSString *_description;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *member_id;

@end

@interface BalanceHistoryListModel : BaseModel

@property (nonatomic, strong) NSMutableArray <BalanceHistoryModel *> *dataList;

@end
