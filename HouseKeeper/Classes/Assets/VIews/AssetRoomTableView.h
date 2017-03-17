//
//  AssetRoomTableView.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/9/11.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseTableView.h"
#import "AssetRoomTableViewCell.h"

@protocol AssetRoomTableViewDelegate <NSObject>

- (void)clickTableViewCellWithModel:(FurnitureModel *)model indexPath:(NSIndexPath *)indexPath;

- (void)showAddFurnitureView;

- (void)deleteFurnitureWithModel:(FurnitureModel *)model;

@end

@interface AssetRoomTableView : BaseTableView

@property (nonatomic, strong) RoomModel *model;

@property (nonatomic, weak) id<AssetRoomTableViewDelegate> clickDelegate;

@end
