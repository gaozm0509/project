//
//  AddAssetViewController.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/15.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseViewController.h"
#import "StateModel.h"

typedef void(^FurnitureModelBlock)(FurnitureModel *model);

@interface AddAssetViewController : BaseViewController

@property (nonatomic, copy) FurnitureModelBlock furnitureModelBlock;

@end
