//
//  LifeServiceTableViewCell.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/11/24.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "LifeServiceTableViewCell.h"
#import <CoreLocation/CoreLocation.h>

static CGFloat kImageWith = 80;

@interface LifeServiceTableViewCell ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, strong) CLLocation *currentLocation;//当前经纬度

@end

@implementation LifeServiceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (UIImageView *)leftImageView{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
    }
    return _leftImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = Color_Hex(@"666666");
        _titleLabel.font = kFont14;
    }
    return _titleLabel;
}

- (BQRatingView *)ratingView{
    if (!_ratingView) {
        _ratingView = [[BQRatingView alloc] initWithFrame:CGRectMake(20 + kImageWith, 0, 100, 20) withStarWidth:10 withStarHeight:10 withEdge:5];
        _ratingView.top = [LifeServiceTableViewCell getHeight] / 2 - _ratingView.height;
    }
    return _ratingView;
}

- (UILabel *)areaLabel{
    if (!_areaLabel) {
        _areaLabel = [[UILabel alloc] init];
        _areaLabel.textColor = Color_Hex(@"666666");
        _areaLabel.font = kFont14;
    }
    return _areaLabel;
}

- (UILabel *)distanceLabel{
    if (!_distanceLabel) {
        _distanceLabel = [[UILabel alloc] init];
        _distanceLabel.textColor = Color_Hex(@"666666");
        _distanceLabel.font = kFont14;
    }
    return _distanceLabel;
}

- (CLLocationManager *)locationManager{
    if (!_locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
        if ([CLLocationManager locationServicesEnabled]) {
            NSLog( @"Starting CLLocationManager" );
        }
        // 设置定位精度
        _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        // distanceFilter是距离过滤器，为了减少对定位装置的轮询次数，位置的改变不会每次都去通知委托，而是在移动了足够的距离时才通知委托程序
        // 它的单位是米，这里设置为至少移动1000再通知委托处理更新;
        _locationManager.distanceFilter = 1000; // 如果设为kCLDistanceFilterNone，则每秒更新一次;
        _locationManager.delegate = self;
    }
    return _locationManager;
}

- (void)setModel:(LifeServiceListModel *)model{
    if (model == _model) {
        return;
    }
    _model = model;
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:kPlaceholderImage];
    _titleLabel.text = _model.title;
    _areaLabel.text = _model.area;
    _ratingView.scoreNum = _model.points.floatValue * 2;
    
    //开始定位
    [self.locationManager startUpdatingLocation];
}



- (void)setupSubViews{
    [self addSubview:self.leftImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.ratingView];
    [self addSubview:self.areaLabel];
    [self addSubview:self.distanceLabel];
    
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(10);
        make.width.offset(kImageWith);
        make.bottom.equalTo(self.mas_bottom).offset(- 10);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(10);
        make.width.mas_lessThanOrEqualTo(200);
        make.height.mas_lessThanOrEqualTo(10);
        make.top.equalTo(self).offset(10);
    }];
    [_areaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.width.mas_lessThanOrEqualTo(200);
        make.height.mas_lessThanOrEqualTo(20);
        make.bottom.equalTo(self.mas_bottom).offset(- 10);
    }];
    [_distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_lessThanOrEqualTo(200);
        make.height.mas_lessThanOrEqualTo(20);
        make.right.equalTo(self.mas_right).offset(-10);
        make.bottom.equalTo(self.mas_bottom).offset(- 10);
    }];
}

+ (CGFloat)getHeight{
    return kImageWith + 20;
}

#pragma mark - 计算距离
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [_locationManager requestWhenInUseAuthorization];
            }
            break;
        default:
            break;
    }
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    //获取一次，获取之后则停止
    [manager stopUpdatingLocation];
    
    //获取当前经纬度
    _currentLocation = [locations lastObject];
    
    _distanceLabel.text = [self getDistance];
}


- (NSString *)getDistance{
    CLLocation *orig = [[CLLocation alloc] initWithLatitude:[_model.latitude doubleValue]  longitude:[_model.longitude doubleValue]];
    
    CLLocationDistance locationDistance = [orig distanceFromLocation:_currentLocation];
    if (locationDistance > 1000) {
        CGFloat distance = locationDistance / 1000;
        return [NSString stringWithFormat:@"%.2fkm",distance];
    }
    else{
        return [NSString stringWithFormat:@"%.2fm",locationDistance];
    }
}

@end

@implementation LifeServiceTableViewCell1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (UIImageView *)leftIcon{
    if (!_leftIcon) {
        _leftIcon = [[UIImageView alloc] init];
        _leftIcon.contentMode = UIViewContentModeCenter;
    }
    return _leftIcon;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = Color_Hex(@"666666");
        _titleLabel.font = kFont14;
    }
    return _titleLabel;
}

- (UIImageView *)rightIcon{
    if (!_rightIcon) {
        _rightIcon = [[UIImageView alloc] init];
        _rightIcon.image = Image(@"向右");
        _rightIcon.contentMode = UIViewContentModeCenter;
    }
    return _rightIcon;
}

- (void)setupSubViews{
    [self addSubview:self.leftIcon];
    [self addSubview:self.titleLabel];
    [self addSubview:self.rightIcon];
    
    [_leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.width.and.height.offset(15);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [_rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.width.and.height.offset(15);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.leftIcon.mas_right).offset(10);
        make.height.mas_lessThanOrEqualTo(20);
        make.right.mas_lessThanOrEqualTo(self.rightIcon.mas_left);
    }];
}

@end


