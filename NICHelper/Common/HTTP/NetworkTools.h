//
//  NetworkTools.h
//  NICHelper
//
//  Created by mac on 16/3/12.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#define XNRequesCallBack (void (^)(id result, NSError *error))finished
/**
 请求方式枚举
 */
typedef enum : NSUInteger {
    GET,
    POST,
    
} XNRequestMethod;

@interface NetworkTools : AFHTTPSessionManager

+ (instancetype)sharedTools;

/** 请求网络的方法 */
- (void)request:(XNRequestMethod)method URLString:(NSString *)URLString parameters:(id) parameters finished:XNRequesCallBack;

/** 天气相关的方法 */
- (void) loadWeatherWithCity:(NSString *)city province:(NSString *)province finished:XNRequesCallBack;

@end
