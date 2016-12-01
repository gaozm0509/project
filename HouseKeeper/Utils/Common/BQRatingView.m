//
//  WineRatingView.m
//  Test
//
//  Created by 胡智斌 on 13-12-13.
//  Copyright (c) 2013年 胡智斌. All rights reserved.
//

#import "BQRatingView.h"

@implementation BQRatingView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self addSubview:self.grayimageView];
    [self addSubview:self.lightImageView];
    self.backgroundColor = [UIColor clearColor];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

        [self addSubview:self.grayimageView];
        [self addSubview:self.lightImageView];
        self.backgroundColor = [UIColor clearColor];
        self.starWidth = 30;
        self.starHeight = 30;
        self.edge = 5;
        self.width = (_starWidth + _edge) * 5;
        self.height = _starHeight;

    }
    return self;
}
//frame的宽度自动设为 (starWidth+edge) * 5 高度设为starHeight
- (id)initWithFrame:(CGRect)frame withStarWidth:(float)starWidth withStarHeight:(float)starHeight withEdge:(float)edge
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self addSubview:self.grayimageView];
        [self addSubview:self.lightImageView];
        self.backgroundColor = [UIColor clearColor];
        self.starWidth = starWidth;
        self.starHeight = starHeight;
        self.edge = edge;
        self.width = (_starWidth + _edge) * 5;
        self.height = _starHeight;
    }
    return self;
}

- (UIImageView *)grayimageView{
    if (!_grayimageView) {
        _grayimageView = [[UIImageView alloc] init];
    }
    return _grayimageView;
}

- (UIImageView *)lightImageView{
    if (!_lightImageView) {
        _lightImageView = [[UIImageView alloc] init];
    }
    return _lightImageView;
}

- (void)drawRect:(CGRect)rect
{
    UIImage *grayStarImg = nil;
    if (self.grayimage) {
        grayStarImg = self.grayimage;
    }else
    {
        grayStarImg = [UIImage imageNamed:@"image_star_gray"];
    }
    UIImage *lightStarImg = nil;

    if (self.lightImage) {
        lightStarImg = self.lightImage;
    }else
    {
        lightStarImg = [UIImage imageNamed:@"image_star_yellow"];
    }
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.width,self.height), NO, [UIScreen mainScreen].scale);

    for (int i = 0; i < 5 ; i++) {
        [grayStarImg drawInRect:CGRectMake(i * (_starWidth + _edge) + (_edge / 2), 0 , _starWidth, _starHeight)];

    }
    
    UIImage* imgBg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    self.grayimageView.image = imgBg;
    
    self.grayimageView.frame = CGRectMake(0, 0, imgBg.size.width, imgBg.size.height);
    
    if (_scoreNum - 0 > 0.000001) {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(_lightImageView.width,self.height), NO, [UIScreen mainScreen].scale);
        
        for (int i = 0; i < 5 ; i++) {
            [lightStarImg drawInRect:CGRectMake(i * (_starWidth + _edge) + (_edge / 2), 0, _starWidth, _starHeight)];
            
        }
        
        UIImage* imgTop = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        self.lightImageView.image = imgTop;
        
        self.lightImageView.frame = CGRectMake(0, 0, imgTop.size.width, self.height);
    }

}
- (void)setScoreNum:(float)scoreNum
{
    _scoreNum = scoreNum;
    //所有小数取0.5
    if (_isByHalf) {
        if ((_scoreNum / 10) != (NSInteger)(_scoreNum / 10)) {
            _scoreNum = (NSInteger)scoreNum + 1;
        }
    }
    //设置黄色星星的宽度
    _lightImageView.width = self.width  * (_scoreNum / 10);
    
    [self setNeedsDisplay];
    
}

@end
