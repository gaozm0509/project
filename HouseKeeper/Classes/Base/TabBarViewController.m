//
//  TabBarViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/16.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self setUpController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if ([viewController isKindOfClass:[PersonalCenterViewController class]]) {
        [self showLoginViewController];
    }
}

- (void)setUpController{
//    UINavigationController *home = [[UINavigationController alloc]initWithRootViewController:[[HomeViewController alloc]init]];
//    UINavigationController *order = [[UINavigationController alloc]initWithRootViewController:[[OrderViewController alloc]init]];
//    UINavigationController *asset = [[UINavigationController alloc]initWithRootViewController:[[AssetViewController alloc]init]];
//    UINavigationController *personalCenter = [[UINavigationController alloc]initWithRootViewController:[[PersonalCenterViewController alloc]init]];
    
    HomeViewController *home = [[HomeViewController alloc] init];
    OrderViewController *order = [[OrderViewController alloc] init];
    AssetViewController *asset = [[AssetViewController alloc] init];
    PersonalCenterViewController *personalCenter = [[PersonalCenterViewController alloc] init];
    
    home.title = @"首页";
    order.title = @"我的订单";
    asset.title = @"我的资产";
    personalCenter.title = @"个人中心";
    self.viewControllers = @[home,order,asset,personalCenter];
    home.tabBarItem.image = [UIImage imageNamed:@"unselected_tab1"];
    order.tabBarItem.image = [UIImage imageNamed:@"unselected_tab2"];
    asset.tabBarItem.image = [UIImage imageNamed:@"unselected_tab3"];
    personalCenter.tabBarItem.image = [UIImage imageNamed:@"unselected_tab4"];
    
    home.tabBarItem.selectedImage = [UIImage imageNamed:@"selected_tab1"];
    order.tabBarItem.selectedImage = [UIImage imageNamed:@"selected_tab2"];
    asset.tabBarItem.selectedImage = [UIImage imageNamed:@"selected_tab3"];
    personalCenter.tabBarItem.selectedImage = [UIImage imageNamed:@"selected_tab4"];
    
}

- (void)setTabar{
    self.tabBar.tintColor = KMajorColor;
    for (int i = 1; i <= 4; i ++) {
        UITabBarItem *item = self.tabBar.items[i-1];
        [item setImage:[UIImage imageNamed:[NSString stringWithFormat:@"unselect_tab%d",i]]];
        [item setSelectedImage:[UIImage imageNamed:[NSString stringWithFormat:@"select_tab%d",i]]];
    }
}

@end
