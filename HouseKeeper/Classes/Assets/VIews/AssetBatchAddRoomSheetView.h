//
//  AssetBatchAddRoomSheetView.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/26.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseSheetView.h"
#import "StateModel.h"

@protocol AssetBatchAddRoomSheetViewDeleagte <NSObject>

- (void)textFieldClickWithIndex:(NSInteger)index;

- (void)AssetBatchAddRoomSheetViewSave;

@end

@interface AssetBatchAddRoomSheetView : BaseSheetView

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic ,strong) UIButton *saveButton;

@property (nonatomic, strong) RoomTypeList *model;

@property (nonatomic, weak) id<AssetBatchAddRoomSheetViewDeleagte>textFieldClickDelegate;

@end

