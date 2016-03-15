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
#pragma mark - -----------------------------------------------------------------


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

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

#pragma mark - -----------------------------------------------------------------


@interface XNResult : NSObject

/** 污染状况 */
@property (nonatomic, copy) NSString *airCondition;

/** 未来几天的天气(包括查询当天的) */
@property (nonatomic, strong) NSArray *future;
/** 天气 */
@property (nonatomic, copy) NSString *weather;


- (instancetype)initWithDict:(NSDictionary *)dict;

@end


#pragma mark - -----------------------------------------------------------------


@interface XNWeatherModel : NSObject

/** 成功/失败 */
@property (nonatomic, copy) NSString *msg;

/** 返回的天气数组 */
@property (nonatomic, strong) NSArray *result;
/** 请求的状态码 */
/**
 *  200 成功
 */
@property (nonatomic, copy) NSString *retCode;

- (instancetype)initWithDict:(NSDictionary *)dict;


@end
