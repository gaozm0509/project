//
//  NewFeaturesViewController.h
//  MBDoctorClient
//
//  Created by 高泽民 on 16/2/5.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseViewController.h"

@interface NewFeaturesViewController : BaseViewController<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIButton *skipButton;

@property (nonatomic, strong) UIPageControl *pageControl;

@end
