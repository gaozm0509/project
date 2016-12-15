//
//  SecondContactsViewController.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/12/4.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseViewController.h"
#import "UserAccout.h"


typedef void(^UserAccoutBlock)(UserAccout *userAccout);

/**
 第二联系人
 */
@interface SecondContactsViewController : BaseViewController

@property (nonatomic, copy) UserAccoutBlock userAccoutBlock;

@end
