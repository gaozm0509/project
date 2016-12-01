//
//  PsersonalInfoViewController.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/11/7.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseViewController.h"
#import "EditPsersonalInfoViewController.h"

typedef void(^UserAccoutBlock)(UserAccout *userAccout);

@interface PsersonalInfoViewController : BaseViewController

@property (nonatomic, copy)UserAccoutBlock userAccoutBlock;

@end
