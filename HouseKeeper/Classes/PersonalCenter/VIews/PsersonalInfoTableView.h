//
//  PsersonalInfoTableView.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/11/7.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseTableView.h"
#import "PsersonalInfoTableViewCell.h"

@protocol PsersonalInfoTableViewDelegate <NSObject>

- (void)editGenderWithGender:(NSInteger)gender;

@end

@interface PsersonalInfoTableView : BaseTableView

@property (nonatomic, weak) id<BaseTableViewDelegate> clickDelegate;

@property (nonatomic, strong) UserAccout *userAccout;

@property (nonatomic, weak) id<PsersonalInfoTableViewDelegate> editGenderDelegate;

@end
