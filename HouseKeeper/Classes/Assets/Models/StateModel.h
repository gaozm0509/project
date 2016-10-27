//
//  StateModel.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/13.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseModel.h"

@interface StateModel : BaseModel

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *deleted_at;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *layout;
@property (nonatomic, copy) NSString *residential;
@property (nonatomic, copy) NSString *updated_at;

@end

@interface StateModelDataModel : BaseModel

@property (nonatomic, copy) NSString *current_page;
@property (nonatomic, copy) NSString *from;
@property (nonatomic, copy) NSString *last_page;
@property (nonatomic, copy) NSString *next_page_url;
@property (nonatomic, copy) NSString *per_page;
@property (nonatomic, copy) NSString *prev_page_url;
@property (nonatomic, copy) NSString *to;
@property (nonatomic, copy) NSString *total;

@property (nonatomic, strong) NSMutableArray<StateModel *> *StateModelList;



@end


@interface RoomType : BaseModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *count;

@end



@interface RoomTypeList : BaseModel

@property (nonatomic, strong) NSMutableArray<RoomType *> *dataList;

@end


@interface OthersModel : BaseModel

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *value;

@end


@interface FurnitureModel : BaseModel

@property (nonatomic, copy) NSString *brand;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *created_by;
@property (nonatomic, copy) NSString *fimei;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *invoice;
@property (nonatomic, copy) NSString *model;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *purchase_date;
@property (nonatomic, copy) NSString *room_id;
@property (nonatomic, copy) NSString *schedule;
@property (nonatomic, copy) NSString *schedule_description;
@property (nonatomic, copy) NSString *schedule_period;
@property (nonatomic, copy) NSString *serial;
@property (nonatomic, copy) NSString *type_id;
@property (nonatomic, copy) NSString *updated_at;
@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) NSMutableArray<OthersModel *> *others;


@end

@interface RoomModel : BaseModel

@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *state_id;
@property (nonatomic, copy) NSString *type_id;
@property (nonatomic, copy) NSString *updated_at;
@property (nonatomic, strong) NSMutableArray<FurnitureModel *> *furnitures;


@end

@interface RoomListModel : BaseModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableArray<RoomModel *> *rooms;

@end


@interface RoomClassModel : BaseModel

@property (nonatomic, strong) NSMutableArray<RoomListModel *> *roomClasses;

@end

