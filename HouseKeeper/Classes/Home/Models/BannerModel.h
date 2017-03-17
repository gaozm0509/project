//
//  BannerModel.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/12/29.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseModel.h"

@class BannerListModel;
@interface BannerModel : BaseModel

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *sort;
@property (nonatomic, strong) NSString *tips;
@property (nonatomic, strong) NSString *type;

@end

@interface BannerListModel : BaseModel

@property (nonatomic, strong) NSMutableArray <BannerModel *> *data;

@end
