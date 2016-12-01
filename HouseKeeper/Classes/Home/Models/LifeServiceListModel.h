//
//  LifeServiceListModel.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/11/24.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseModel.h"



/**
 address;       详细地址
 area;          区域
 created_at;    创建时间
 _description;  服务说明
 id;            服务id
 image_url;     图片url
 latitude;      经度
 longitude;     维度
 points;        评分/星星
 telephone;     电话
 title;         标题
 type_id;       类型1-8
 updated_at;
 */
@interface LifeServiceListModel : BaseModel

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *_description;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *image_url;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *points;
@property (nonatomic, copy) NSString *telephone;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *type_id;
@property (nonatomic, copy) NSString *updated_at;



@end

/**
 接收数组
 */
@interface LifeServiceListDataModel : BaseModel

@property (nonatomic, strong) NSMutableArray<LifeServiceListModel *> *dataList;

@property (nonatomic, assign) BOOL isDetailViewController;

@end
