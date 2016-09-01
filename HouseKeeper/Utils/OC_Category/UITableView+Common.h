//
//  UITableView+Common.h
//  HX_Finance
//
//  Created by king on 15/1/19.
//  Copyright (c) 2015年 Sharing. All rights reserved.
//

@interface UITableView(Common)

- (void)addRadiusforCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)addLineforPlainCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withLeftSpace:(CGFloat)leftSpace;

@end
