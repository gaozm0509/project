//
//  DoorEntryModel.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/31.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseModel.h"

@interface DoorEntryModel : BaseModel

/*price_id的值
 1:资产工单，
 2高级资产工单，
 3保养，
 4保修，
 5空气检测
 */
@property (nonatomic, copy) NSString *codeStr;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *price;

@end
