//
//  XNWeatherView.m
//  NICHelper
//
//  Created by mac on 16/3/12.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNWeatherView.h"
#import <Masonry.h>
#import <YYModel/YYModel.h>
#import "XNWeather.h"
#import "NetworkTools.h"


@interface XNWeatherView ()

/** 污染状况 */
@property (nonatomic, strong) UIButton *airConditionBtn;
/** 温度 */
@property (nonatomic, strong) UIButton *temperatureBtn;
/** 风向 */
@property (nonatomic, strong) UIButton *windBtn;
/** 天气 */
@property (nonatomic, strong) UIButton *weatherBtn;
/** 定位 */
@property (nonatomic, strong) UIButton *loactionBtn;

@end

@implementation XNWeatherView
/**
    airCondition: "轻度污染",
    wind: "东南风 3～4级"
    weather: "多云"
    temperature: "14°C / 5°C",
 */

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self setupData];
    }
    return self;
}

#pragma mark - 懒加载

- (UIButton *)weatherBtn {
    if (_weatherBtn == nil) {
        _weatherBtn = [[UIButton alloc]init];
        [_weatherBtn setTitle:@"多云" forState:UIControlStateNormal];
        [_weatherBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _weatherBtn;
}

- (UIButton *)temperatureBtn {
    if (_temperatureBtn == nil) {
        _temperatureBtn = [[UIButton alloc]init];
        [_temperatureBtn setTitle:@"14°C / 5°C" forState:UIControlStateNormal];
        [_temperatureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _temperatureBtn;
}

- (UIButton *)windBtn {
    if (_windBtn == nil) {
        _windBtn = [[UIButton alloc]init];
        [_windBtn setTitle:@"东南风 3～4级" forState:UIControlStateNormal];
        [_windBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _windBtn;
}

- (UIButton *)airConditionBtn {
    if (_airConditionBtn == nil) {
        _airConditionBtn = [[UIButton alloc]init];
        [_airConditionBtn setTitle:@"轻度污染" forState:UIControlStateNormal];
        [_airConditionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _airConditionBtn;
}

- (UIButton *)loactionBtn {
    if (_loactionBtn == nil) {
        _loactionBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [_loactionBtn setBackgroundImage:[UIImage imageNamed:@"locationt"] forState:UIControlStateNormal];
    }
    return _loactionBtn;
}

- (void)setupUI {

    //添加控件
    [self addSubview:self.weatherBtn];
    [self addSubview:self.temperatureBtn];
    [self addSubview:self.windBtn];
    [self addSubview:self.airConditionBtn];
    [self insertSubview:self.loactionBtn belowSubview:self];
    
    CGFloat padding = 15;
    // 自动布局
    [_weatherBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_centerX).offset(-padding);
        make.bottom.equalTo(self.mas_centerY).offset(-padding);
        
    }];
    
    [_temperatureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_centerY).offset(padding);
        make.right.equalTo(self.mas_centerX).offset(-padding);
    }];
    
    [_windBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).offset(padding);
        make.bottom.equalTo(self.mas_centerY).offset(-padding);
    }];
    
    [_airConditionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).offset(padding);
        make.top.equalTo(self.mas_centerY).offset(padding);

    }];
    [_loactionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.and.height.equalTo(@(40));
    }];
    
    // 添加监听
    [_loactionBtn addTarget:self action:@selector(loactionClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setupData {
    // 测试网络方法
    [[NetworkTools sharedTools] request:GET URLString:@"http://apicloud.mob.com/v1/weather/query" parameters:@{@"key":@"10557a5d75b9c",@"city":@"南宁",@"province":@"江苏"} finished:^(id result, NSError *error) {
        if (error) {
            NSLog(@"解析出错--%@",error);
            return ;
        }
        
        NSString *temp = result[@"result"][0][@"future"][0][@"temperature"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.temperatureBtn setTitle:temp forState:UIControlStateNormal];
        });
    }];

}

- (void)loactionClick {
    NSLog(@"定位");
}
@end
