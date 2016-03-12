//
//  XNCoverView.m
//  NICHelper
//
//  Created by mac on 16/3/12.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNCoverView.h"
#import "XNColor.h"
#import <Masonry.h>

@interface XNCoverView ()

/** 天气 */
@property (strong, nonatomic) UIButton *temperatureBtn;

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

- (UIButton *)temperatureBtn {
    if (_temperatureBtn == nil) {
        _temperatureBtn = [[UIButton alloc]init];
        _temperatureBtn.layer.cornerRadius = 5;
        _temperatureBtn.layer.masksToBounds = YES;
        _temperatureBtn.backgroundColor = XNColor(255, 255, 255, 0.8);
    }
    return _temperatureBtn;
}


- (void)setupUI {
    
    self.backgroundColor = XNColor(59, 59, 59, 0.5);
    // 添加控件
    [self addSubview:self.temperatureBtn];
    CGFloat Xmargin = 20;
    CGFloat width = 100;
    CGFloat topMargin = (kParallaxHeaderHeight - width - 64) * 0.5;
    //自动布局
    
    
    [_temperatureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(Xmargin);
        make.top.equalTo(self).offset(topMargin);
        make.height.equalTo(@(width));
        make.width.equalTo(@(DEFAULT_WIDTH - 2 * Xmargin));
    }];


}


@end
