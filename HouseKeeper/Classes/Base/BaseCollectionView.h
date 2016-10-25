//
//  BaseCollectionView.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/24.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"

@protocol  BaseCollectionViewDelegate <NSObject>

- (void)BaseTableViewClickWithModel:(BaseModel *)baseModel;

- (void)BaseTableViewClickWithIndexPath:(NSIndexPath *)indexPath;

@end

@interface BaseCollectionView : UICollectionView

@end
