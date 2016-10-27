//
//  LifeServiceCollectionView.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/24.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseCollectionView.h"
#import "LifeServiceCollectionViewCell.h"

@protocol LifeServiceCollectionViewDelegate <NSObject>

- (void)clickItemWithIndexPath:(NSIndexPath *)indexPath;

@end

@interface LifeServiceCollectionView : BaseCollectionView

@property (nonatomic, strong) id<LifeServiceCollectionViewDelegate> clickDelegate;

@end
