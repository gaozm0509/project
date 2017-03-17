//
//  AbstractActionSheetPicker+GetToolBarButton.m
//  HouseKeeper
//
//  Created by 高泽民 on 2017/2/21.
//  Copyright © 2017年 zm. All rights reserved.
//

#import "AbstractActionSheetPicker+GetToolBarButton.h"

@implementation AbstractActionSheetPicker (GetToolBarButton)

- (UIBarButtonItem *)getDoneButton{
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton setTitleColor:KMajorColor forState:UIControlStateNormal];
    doneButton.titleLabel.font = kFont14;
    [doneButton setTitle:@"确定" forState:UIControlStateNormal];
    doneButton.frame = CGRectMake(0, 0, 44, 44);
    return [[UIBarButtonItem alloc]initWithCustomView:doneButton];
    
}

- (UIBarButtonItem *)getCancelButton{
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton setTitleColor:KMajorColor forState:UIControlStateNormal];
    doneButton.titleLabel.font = kFont14;
    [doneButton setTitle:@"取消" forState:UIControlStateNormal];
    doneButton.frame = CGRectMake(0, 0, 44, 44);
    return [[UIBarButtonItem alloc]initWithCustomView:doneButton];
}

@end
