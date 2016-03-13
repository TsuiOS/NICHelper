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
        _temperatureView.backgroundColor = [UIColor clearColor];
    }
    return _temperatureView;
}


- (void)setupUI {
    
    self.backgroundColor = XNColor(0, 0, 0, 0.5);
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
