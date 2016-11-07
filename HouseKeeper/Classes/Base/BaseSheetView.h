//
//  BaseSheetView.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/13.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseVIew.h"

@class BaseSheetView;

@protocol BaseSheetViewDelegate <NSObject>

- (void)BaseSheetViewSave;

@end

@interface BaseSheetView : BaseVIew

@property (nonatomic, weak) id<BaseSheetViewDelegate> delegate;

- (void)show;

- (void)hid;


@end
