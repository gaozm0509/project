//
//  LifeServiceCollectionView.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/24.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseCollectionView.h"
#import "LifeServiceCollectionViewCell.h"
#import "BannerModel.h"

@protocol LifeServiceCollectionViewDelegate <NSObject>

- (void)clickItemWithIndexPath:(NSIndexPath *)indexPath;

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;

@end

@interface LifeServiceCollectionView : BaseCollectionView

@property (nonatomic, strong) id<LifeServiceCollectionViewDelegate> clickDelegate;

@property (nonatomic, strong) BannerListModel *bannerListModel;

@end
