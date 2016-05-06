//
//  XNLocationController.m
//  NICHelper
//
//  Created by mac on 16/3/20.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNLocationController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

@interface XNLocationController ()<BMKMapViewDelegate,BMKLocationServiceDelegate>{
    
    BMKMapView* _mapView;
    BMKLocationService* _locService;
    
}
@property (nonatomic, strong) CLLocationManager *manager;
@property (nonatomic, strong) BMKUserLocation *userLocation;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *province;

@end

@implementation XNLocationController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_back_normal"] style: UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.title = @"开始定位";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(startLocation)];
    
    self.manager = [CLLocationManager new];
    // 请求授权
    if ([self.manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        
        [self.manager requestWhenInUseAuthorization];
    }

    
    _mapView = [[BMKMapView alloc]init];
    self.view = _mapView;

    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层

}
-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    
}

#pragma mark - 返回用户的位置
- (void)startLocation {
    NSLog(@"进入普通定位态");

    // 设置范围 - 包含了经纬度和显示跨度
    CLLocationCoordinate2D center = self.userLocation.location.coordinate;
    BMKCoordinateSpan span = BMKCoordinateSpanMake(0.1, 0.1);
    [_mapView setRegion:BMKCoordinateRegionMake(center, span) animated:YES];
  
    CLGeocoder *geocoder = [CLGeocoder new];
    //2. 调用方法 传入当前位置
    [geocoder reverseGeocodeLocation:self.userLocation.location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        //2.1 防错处理
        if (placemarks.count == 0 || error) {
            NSLog(@"error");
            return;
        }
        //placemarks 地标对象数组
        //这里将会有多个返回结果, 应该给用户一个列表选择
        for (CLPlacemark *placemark in placemarks) {
            
            // 设置标题
            if (placemark.locality) {
                self.userLocation.title = placemark.locality;
                self.province = placemark.administrativeArea;
            } else {
                self.userLocation.title = placemark.administrativeArea;
                self.province = placemark.administrativeArea;
            }
            self.city = placemark.locality;
            // 设置子标题
            self.userLocation.subtitle = placemark.name;
        }
    }];

    
}

//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    
    _mapView.centerCoordinate = userLocation.location.coordinate;
    
    [_mapView updateLocationData:userLocation];
    self.userLocation = userLocation;
}


/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error--%@",error);
}


- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}

- (void)back {
    
    if (self.completion) {
        self.completion(self.city,self.province);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}





@end
