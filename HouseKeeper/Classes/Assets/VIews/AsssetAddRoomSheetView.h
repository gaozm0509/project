//
//  AsssetAddRoomSheetView.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/13.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseSheetView.h"

@interface AsssetAddRoomSheetView : BaseSheetView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *roomNameField;
@property (nonatomic, strong) UITextField *roomTypeField;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *roomTypeButton;
@property (nonatomic, strong) UIButton *savebutton;

@end


@interface AssetDeleteRoomSheetView : BaseSheetView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UIButton *savebutton;

@end
