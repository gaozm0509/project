//
//  BaseSheetView.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/13.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseSheetView.h"

//记录self出现开始时的frame或者消失时结束时的frame
#define kFrame CGRectMake(0, kScreen_Height, kScreen_Width, self.frame.size.height)

@interface BaseSheetView()

@property(nonatomic, strong) UIView *bgView;

@end

@implementation BaseSheetView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)show{
    _bgView = [[UIView alloc]initWithFrame:kScreen_Bounds];
    _bgView.backgroundColor = [UIColor colorWithHexString:@"000000" andAlpha:0];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgViewClick)];
    [_bgView addGestureRecognizer:gesture];
    
    //记录sele.view最后的frame
    CGRect frame = CGRectMake(0, kScreen_Height - self.frame.size.height, kScreen_Width, self.frame.size.height);
    self.frame = kFrame;
    
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    [window.rootViewController.view addSubview:_bgView];
    [window.rootViewController.view addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = frame;
        _bgView.backgroundColor = [UIColor colorWithHexString:@"0000000" andAlpha:0.2];
    }];
}

- (void)hid{
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = kFrame;
        _bgView.backgroundColor = [UIColor colorWithHexString:@"000000" andAlpha:0];
    } completion:^(BOOL finished) {
        [_bgView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (void)bgViewClick{
    [self hid];
}

@end
