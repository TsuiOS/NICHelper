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
- (void)loadWeatherWithCity:(NSString *)city province:(NSString *)province finished:XNRequesCallBack;

/** 加载用户信息*/
- (void)loadUserInfoWithToken:(NSString *)tokenString finished:XNRequesCallBack;

/** 发布 Tips*/
- (void)composeTipsWithTitle:(NSString *)title content:(NSString *)content from:(NSString *)from finished:XNRequesCallBack;

/** 发起任务 */
- (void)composeMessageWithTitle:(NSString *)title address:(NSString *)address phone:(NSString *)phone number:(NSString *)number studentName:(NSString *)studentName reason:(NSString *)reason finished:XNRequesCallBack;

/** 更新维修进度 */
- (void)updateMessageWithFinish:(NSInteger)finish result:(NSString *)result finishName:(NSString *)finishName progress:(NSString *)progress uid:(NSString *)uid finished:XNRequesCallBack;
@end
