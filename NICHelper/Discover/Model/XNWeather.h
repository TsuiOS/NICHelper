//
//  XNWeather.h
//  NICHelper
//
//  Created by mac on 16/3/12.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 "airCondition": "轻度污染",
 "temperature": "14°C / 5°C",
 "wind": "东南风 3～4级"
 "weather": "多云",

 
 */



@interface XNResult : NSObject

/** 污染状况 */
@property (nonatomic, copy) NSString *airCondition;
/** 天气 */
@property (nonatomic, copy) NSString *weather;
/** 当前温度 */
@property (nonatomic, copy) NSString *temperature;
/** 风向 */
@property (nonatomic, copy) NSString *wind;

@end


@interface XNWeather : NSObject

@property (nonatomic, strong) XNResult *result;

@end



