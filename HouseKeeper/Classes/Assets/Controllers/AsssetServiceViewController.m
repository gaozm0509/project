//
//  AsssetServiceViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/16.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "AsssetServiceViewController.h"
#import "AsssetServiceTableView.h"
#import <CoreLocation/CoreLocation.h>

#define kBottomViewHeight 90

@interface AsssetServiceViewController ()<CLLocationManagerDelegate,AsssetServiceTableViewDelegate>

@property (nonatomic, strong) FurnitureModel *furnitureModel;

@property (nonatomic, strong) AsssetServiceTableView *tableView;

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, strong) NSString *city;


@end


@implementation AsssetServiceViewController

#pragma mark - Cycle life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"服务";
    
    _furnitureModel = self.receiveParams[@"model"];
    
    [self.view addSubview:self.tableView];
    
    //定位
    [self setLocationManager];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getter and setter

- (AsssetServiceTableView *)tableView{
    if (!_tableView) {
        _tableView = [[AsssetServiceTableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height - kNavHeight - kBottomViewHeight)];
        _tableView.furnitureModel = _furnitureModel;
        _tableView.clickDelegate = self;
    }
    return _tableView;
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
            
            //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
            if (!city) {
                city = placemark.administrativeArea;
            }
            
            _city = city;
            
            _tableView.city = _city;
        }
        
    }];
}

#pragma mark AsssetServiceTableViewDelegate

//保养周期
- (void)schedule_periodCellClick{
    NSLog(@"schedule_periodCellClick");
}

//选择保养还是保修
- (void)chosenMaintenanceOrWarrantyButton:(BOOL)isMaintenance{
    if (isMaintenance) {
        //保养
        NSLog(@"保养");
    }
    else{
        //保修
        NSLog(@"修");
    }
}

#pragma mark - Net request



#pragma mark - Event method



#pragma mark - Pravit method

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
