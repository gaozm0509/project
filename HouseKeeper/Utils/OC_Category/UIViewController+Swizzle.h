//
//  UIViewController+Swizzle.h
//  HX_Finance
//
//  Created by king on 14-8-1.
//  Copyright (c) 2014年 Sharing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Swizzle)
- (void)customViewDidLoad;

@end

void swizzleAllViewController();