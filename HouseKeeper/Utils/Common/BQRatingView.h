//
//  WineRatingView.h
//  Test
//
//  Created by 胡智斌 on 13-12-13.
//  Copyright (c) 2013年 胡智斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BQRatingView : UIView

//frame的宽度自动设为 (starWidth+edge) * 5 高度设为starHeight
- (id)initWithFrame:(CGRect)frame withStarWidth:(float)starWidth withStarHeight:(float)starHeight withEdge:(float)edge;

@property(nonatomic,assign) CGFloat starWidth;         //单个星星宽度
@property(nonatomic,assign) CGFloat starHeight;        //单个星星长度
@property(nonatomic,assign) CGFloat edge;              //每个星星的间隔
@property(nonatomic,assign)float scoreNum;             //分数
@property (nonatomic,retain)UIImage *lightImage;       //更改亮星星图片
@property (nonatomic,retain)UIImage *grayimage;        //更改暗星星图片

@property (nonatomic,retain)UIImageView *lightImageView;
@property (nonatomic,retain)UIImageView *grayimageView;

@property (nonatomic,assign)BOOL isByHalf;              //是否折半，有小数点则取0.5

@end
