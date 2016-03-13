//
//  XNWeatherModel.h
//  NICHelper
//
//  Created by mac on 16/3/13.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 "airCondition": "轻度污染",
 "temperature": "14°C / 5°C",
 "wind": "东南风 3～4级"
 "weather": "多云",
 
 */

@interface XNFuture : NSObject

/** 日期 */
@property (nonatomic, strong) NSString *date;
/** dayTime */
@property (nonatomic, strong) NSString *dayTime;
/** night */
@property (nonatomic, strong) NSString *night;
/** 当前温度 */
@property (nonatomic, copy) NSString *temperature;
/** week */
@property (nonatomic, strong) NSString *week;
/** 风向 */
@property (nonatomic, copy) NSString *wind;


@end



@interface XNResult : NSObject

/** 污染状况 */
@property (nonatomic, copy) NSString *airCondition;

/** 未来几天的天气(包括查询当天的) */
@property (nonatomic, strong) NSArray *future;
/** 天气 */
@property (nonatomic, copy) NSString *weather;

@end


@interface XNWeatherModel : NSObject

/** 返回的天气数组 */
@property (nonatomic, strong) NSArray *result;
/** 请求的状态码 */
/**
 *  200 成功
 */
@property (nonatomic, strong) NSString *retCode;


//发送异步请求加载数据
/**
 *  定义一个块代码的属性
 */

+ (void)weatherWithSuccess:(void(^)(NSDictionary *weatherDict))success;

@end
