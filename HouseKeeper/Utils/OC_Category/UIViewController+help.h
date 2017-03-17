//
//  UIViewController+help.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/9/11.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (help)

- (void)pushNewViewController:(NSString *)VCName params:(NSDictionary *)params;

- (void)pushNewViewController:(NSString *)VCName;

- (void)pushNewViewController:(NSString *)VCName params:(NSDictionary *)params animated:(BOOL)animated;

@end
