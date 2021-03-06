//
//  AssetTableViewCell.h
//  HouseKeeper
//
//  Created by gzm on 16/9/11.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "StateModel.h"


@interface AssetTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *rightIcon;

@property (nonatomic, strong) RoomModel *roomModel;

@end


@interface AssetTableViewFirstCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) RoomListModel *roomListModel;



@end



@protocol AssetTableHeadViewCellDelegate <NSObject>

//采集
- (void)assetCollection;
//更换
- (void)assetChange;

@end

@interface AssetTableHeadViewCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *communityLabel;
@property (nonatomic, strong) UILabel *apartmentLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UIButton *collectionButton;
@property (nonatomic, strong) UIButton *changeButton;

@property (nonatomic , strong) StateModel *model;

@property (nonatomic, weak) id<AssetTableHeadViewCellDelegate> delegate;

@end
