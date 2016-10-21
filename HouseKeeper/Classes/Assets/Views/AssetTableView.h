//
//  AssetTableView.h
//  HouseKeeper
//
//  Created by gzm on 16/9/11.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableView.h"
#import "AssetTableViewCell.h"

@protocol AssetTableViewDelegate <NSObject>

//采集
- (void)assetCollection;
//更换
- (void)assetChange;

- (void)clickTableViewCellWithModel:(RoomModel *)model;

@end

@interface AssetTableView : BaseTableView

@property (nonatomic, weak) id<AssetTableViewDelegate> clickDelegate;

@property (nonatomic , strong) StateModel *model;

@property (nonatomic, strong) RoomClassModel *roomClassModel;

@end
