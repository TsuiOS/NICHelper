//
//  XNWeatherView.m
//  NICHelper
//
//  Created by mac on 16/3/12.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNWeatherView.h"
#import <Masonry.h>
#import "XNProgressHUD.h"
#import "XNWeatherModel.h"


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


@property (nonatomic, strong) XNResult *result;

@end

@implementation XNWeatherView


#pragma mark - 懒加载

- (UIButton *)weatherBtn {
    if (_weatherBtn == nil) {
        _weatherBtn = [[UIButton alloc]init];
        [_weatherBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _weatherBtn;
}

- (UIButton *)temperatureBtn {
    if (_temperatureBtn == nil) {
        _temperatureBtn = [[UIButton alloc]init];
        [_temperatureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _temperatureBtn;
}

- (UIButton *)windBtn {
    if (_windBtn == nil) {
        _windBtn = [[UIButton alloc]init];
        [_windBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _windBtn;
}

- (UIButton *)airConditionBtn {
    if (_airConditionBtn == nil) {
        _airConditionBtn = [[UIButton alloc]init];
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

- (void)layoutSubviews {

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

- (void)setCurrentWeatherData:(XNWeatherModel *)CurrentWeatherData {
    
    _CurrentWeatherData = CurrentWeatherData;
    XNResult *result = self.CurrentWeatherData.result.firstObject;
    XNFuture *todayInfo = result.future.firstObject;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.airConditionBtn setTitle:result.airCondition forState:UIControlStateNormal];
        [self.weatherBtn setTitle:result.weather forState:UIControlStateNormal];
        [self.temperatureBtn setTitle:todayInfo.temperature forState:UIControlStateNormal];
        [self.windBtn setTitle:todayInfo.wind forState:UIControlStateNormal];
    });
   


}
- (void)loactionClick {
    NSLog(@"定位");
}
@end
