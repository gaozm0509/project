//
//  CreatOrderTableViewCell.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/11/4.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "CreatOrderTableViewCell.h"
#import <CoreLocation/CoreLocation.h>

@interface CreatOrderTableViewCell()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end


@implementation CreatOrderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubViews];
        [self setLocationManager];
    }
    return self;
}

- (UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc] init];
        _phoneLabel.text = [NSString stringWithFormat:@"手机号：%@",[UsersManager phone]];
        _phoneLabel.textColor = Color_Hex(@"666666");
        _phoneLabel.font = kFont14;
    }
    return _phoneLabel;
}

- (UILabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.textColor = Color_Hex(@"666666");
        _addressLabel.font = kFont14;
    }
    return _addressLabel;
}

- (void)setupSubViews{
    [self addSubview:self.addressLabel];
    [self addSubview:self.phoneLabel];
    
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.height.equalTo(@30);
        make.top.equalTo(self).offset(5);
        make.width.lessThanOrEqualTo(@(kScreen_Width));
    }];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.height.equalTo(@30);
        make.bottom.equalTo(self.mas_bottom).offset(- 5);
        make.width.lessThanOrEqualTo(@(kScreen_Width));
    }];
}

#pragma mark - Delegate

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
    CLLocation *currentLocation = [locations lastObject];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (error) {
            [self showError:error];
            return ;
        }
        
        if (placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks firstObject];
            
            NSString *city = placemark.locality;
            NSString *area = placemark.subLocality;
            NSString *addressName = placemark.name;
            
            //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
            if (!city) {
                city = placemark.administrativeArea;
                area =placemark.subAdministrativeArea;;
            }
            
            _addressLabel.text = [NSString stringWithFormat:@"%@%@%@",city,area,addressName];
        }
        
    }];
}

//定位
- (void)setLocationManager{
    self.locationManager = [[CLLocationManager alloc] init];
    if ([CLLocationManager locationServicesEnabled]) {
        NSLog( @"Starting CLLocationManager" );
    }
    _locationManager.delegate = self;
    // 设置定位精度
    _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    // distanceFilter是距离过滤器，为了减少对定位装置的轮询次数，位置的改变不会每次都去通知委托，而是在移动了足够的距离时才通知委托程序
    // 它的单位是米，这里设置为至少移动1000再通知委托处理更新;
    _locationManager.distanceFilter = 1000; // 如果设为kCLDistanceFilterNone，则每秒更新一次;
    [_locationManager startUpdatingLocation];
}


@end
