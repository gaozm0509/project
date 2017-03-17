//
//  LifeServiceCollectionViewCell.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/24.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "LifeServiceCollectionViewCell.h"

@interface LifeServiceCollectionViewCell()

@property (nonatomic, strong) NSArray<NSString *> *imageArr;

@end

@implementation LifeServiceCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
        self.backgroundColor = kBackgroundColor;
        
        _imageArr = @[@"service_维修",@"service_绿植",@"service_洗衣",@"service_保洁",@"service_地毯清洗",@"service_装修",@"service_京东",@"service_汽车维修"];
    }
    return self;
}

- (SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        CGRect frame = CGRectMake(10, 10, kScreen_Width-20, kScreen_Height/4.5);
        NSArray *array = @[[UIImage imageNamed:@"banner01@3x"],[UIImage imageNamed:@"banner02@3x"],[UIImage imageNamed:@"banner03@3x"],[UIImage imageNamed:@"banner04@3x"]];
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame imageNamesGroup:array];
        _cycleScrollView.layer.cornerRadius = 10;
        _cycleScrollView.layer.masksToBounds = YES;
        _cycleScrollView.autoScrollTimeInterval = 3;
    }
    return _cycleScrollView;
}

- (void)setupSubViews{
    [self addSubview:self.cycleScrollView];
    
}

- (void)setBannerListModel:(BannerListModel *)bannerListModel{
    NSMutableArray *imgArray = [NSMutableArray array];
    for (BannerModel *banner in bannerListModel.data) {
        [imgArray addObject:[NSString stringWithFormat:@"%@/%@",kApi_Host,banner.img]];
    }
    [self.cycleScrollView setImageURLStringsGroup:imgArray];
}


+ (CGSize)getCellSize{
    return CGSizeMake(kScreen_Width, kScreen_Height / 4.5 + 10);
}

@end

@implementation LifeServiceCollectionViewCell1

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.contentMode = UIViewContentModeCenter;
    }
    return _imageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = kFont14;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = kFont12;
        _contentLabel.textColor = Color_Hex(@"a4a4a4");
    }
    return _contentLabel;
}

- (void)setIndexRow:(NSInteger)indexRow{
    _indexRow = indexRow;
    
    switch (_indexRow) {
        case 0:{
            _titleLabel.text = @"99录入入资产";
            _titleLabel.textColor = Color_Hex(@"ff8f3b");
            _contentLabel.text = @"专业团队上门录入";
            _imageView.image = Image(@"service_资产录入");
            break;
        }
        case 1:{
            _titleLabel.text = @"冲500返50";
            _titleLabel.textColor = Color_Hex(@"ed777b");
            _contentLabel.text = @"多冲多反";
            _imageView.image = Image(@"service_充值");
            break;
        }
        case 2:{
            _titleLabel.text = @"房屋资产深度检测";
            _titleLabel.textColor = Color_Hex(@"3e9aff");
            _contentLabel.text = @"全套资产录入手机";
            _imageView.image = Image(@"service_深度资产录入");
            break;
        }
        case 3:{
            _titleLabel.text = @"空气治理";
            _titleLabel.textColor = Color_Hex(@"80269");
            _contentLabel.text = @"检测治理房屋空气";
            _imageView.image = Image(@"service_空气治理");
            break;
        }
            
        default:
            break;
    }
    
}

- (void)setupSubViews{
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.contentLabel];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.right.equalTo(self.mas_right).offset(- 10);
        make.bottom.equalTo(self.mas_bottom).offset(- 10);
        make.width.equalTo(_imageView.mas_height).offset(- 5);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.lessThanOrEqualTo(_imageView.mas_left).offset(- 5);
        make.height.lessThanOrEqualTo(@20);
        make.bottom.equalTo(self.mas_centerY);
    }];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_centerY).offset(5);
        make.left.equalTo(self).offset(10);
        make.right.lessThanOrEqualTo(_imageView.mas_left).offset(- 5);
        make.height.lessThanOrEqualTo(@20);
    }];
}

+ (CGSize)getCellSize{
    CGFloat width = (kScreen_Width - 0.5) / 2;
    CGFloat height = 75;
    return CGSizeMake(width, height);
}

@end


@implementation LifeServiceCollectionViewCell2

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.button];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (UIButton *)button{
    if (!_button) {
        CGFloat buttonW = (kScreen_Width - 1) / 2;
        CGFloat buttonH = 150;
        _button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonW, buttonH) verticalValue:10 title:@"绿植水培" image:Image(@"service_活动－水培") font:kFont14];
        [_button setTitleColor:KMajorColor forState:UIControlStateNormal];
        _button.userInteractionEnabled = NO;
    }
    return _button;
}

- (void)setIndexRow:(NSInteger)indexRow{
    _indexRow = indexRow;
    if (_indexRow == 0) {
        [_button setImage:Image(@"service_活动－水培") forState:UIControlStateNormal];
        [_button setTitle:@"绿植水陪" forState:UIControlStateNormal];
    }
    else{
        [_button setImage:Image(@"service_活动－楼盘") forState:UIControlStateNormal];
        [_button setTitle:@"楼盘介绍" forState:UIControlStateNormal];
    }
}


+ (CGSize)getCellSize{
    CGFloat width = (kScreen_Width - 1) / 2;
    CGFloat height = 150;
    return CGSizeMake(width, height);
}

@end

@implementation LifeServiceCollectionViewCell3

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.textColor = [UIColor blackColor];
//        _textLabel.text = @"我的";
        _textLabel.font = kFont14;
        _textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _textLabel.numberOfLines = 0;
    }
    return _textLabel;
}

- (void)setupSubViews{
    [self addSubview:self.textLabel];
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom).offset(- 10);
    }];
}

+ (CGSize)getCellSize{
    return CGSizeMake(kScreen_Width, 50);
}

@end
