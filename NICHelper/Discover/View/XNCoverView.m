//
//  XNCoverView.m
//  NICHelper
//
//  Created by mac on 16/3/12.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNCoverView.h"
#import "XNColor.h"
#import "XNWeatherView.h"
#import <Masonry.h>

@interface XNCoverView ()

/** 天气 */
@property (strong, nonatomic) XNWeatherView *temperatureView;

@end

@implementation XNCoverView

- (instancetype)initWithFrame:(CGRect)frame {
   self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark - 懒加载

- (XNWeatherView *)temperatureView {
    if (_temperatureView == nil) {
        _temperatureView = [[XNWeatherView alloc]init];
        _temperatureView.layer.cornerRadius = 10;
        _temperatureView.layer.masksToBounds = YES;
        _temperatureView.backgroundColor = XNColor(255, 255, 255, 0);
    }
    return _temperatureView;
}


- (void)setupUI {
    
    self.backgroundColor = XNColor(59, 59, 59, 0.7);
    // 添加控件
    [self addSubview:self.temperatureView];
    CGFloat Xmargin = 20;
    CGFloat width = 100;
    CGFloat topMargin = (kParallaxHeaderHeight - width - 64) * 0.5;
    //自动布局
    
    
    [_temperatureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(Xmargin);
        make.top.equalTo(self).offset(topMargin);
        make.height.equalTo(@(width));
        make.width.equalTo(@(DEFAULT_WIDTH - 2 * Xmargin));
    }];


}


@end
