//
//  LifeServiceCollectionViewCell.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/24.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCollectionViewCell.h"

@interface LifeServiceCollectionViewCell : BaseCollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) NSInteger indexRow;

+ (CGSize)getCellSize;


@end

@interface LifeServiceCollectionViewCell1 : BaseCollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, assign) NSInteger indexRow;

+ (CGSize)getCellSize;

@end

@interface LifeServiceCollectionViewCell2 : BaseCollectionViewCell

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, assign) NSInteger indexRow;

+ (CGSize)getCellSize;

@end

@interface LifeServiceCollectionViewCell3 : BaseCollectionViewCell

@property (nonatomic, strong) UILabel *textLabel;

+ (CGSize)getCellSize;

@end
