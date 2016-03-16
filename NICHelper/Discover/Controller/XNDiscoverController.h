//
//  XNDiscoverController.h
//  NICHelper
//
//  Created by mac on 16/3/7.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XNWeatherView;
@class XNWeatherModel;

@protocol XNDiscoverControllerDelgate <NSObject>

/** 刷新天气 */
- (void)refreshWeatherInfo:(XNWeatherModel *)weatherInfo;

@end

@interface XNDiscoverController : UIViewController

@property (nonatomic, strong) id<XNDiscoverControllerDelgate> delegate;


@end
