//
//  BaseViewController.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/16.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, strong) NSDictionary *receiveParams;

@property (nonatomic, strong) UIImage *backgroundImage;

- (void)netRequest;

@end
