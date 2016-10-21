//
//  AssetAddOthersSheetView.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/17.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseSheetView.h"

@interface AssetAddOthersSheetView : BaseSheetView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *valueField;
@property (nonatomic, strong) UIButton *savebutton;

@end
