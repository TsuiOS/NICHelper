//
//  XNCoverView.h
//  NICHelper
//
//  Created by mac on 16/3/12.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XNWeatherView;

@interface XNCoverView : UIView

/** 天气 */
@property (strong, nonatomic) XNWeatherView *temperatureView;

@end
