//
//  NetworkTools.m
//  NICHelper
//
//  Created by mac on 16/3/12.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "NetworkTools.h"

/**
 *  网络工具协议
 */
@protocol NetworkToolsProxy <NSObject>

/**
 *  网络请求方法 - AFN 核心代码
 *
 *  @param method           HTTP 请求方法
 *  @param URLString        URLString
 *  @param parameters       参数字典
 *  @param uploadProgress   长传进度
 *  @param downloadProgress 下载进度
 *  @param success          成功回调
 *  @param failure          失败回调
 *
 *  @return NSURLSessionDataTask
 */
@optional
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

@end

/**
 *  遵守网络协议 - 智能提示
 */
@interface NetworkTools () <NetworkToolsProxy>

@end

@implementation NetworkTools

+ (instancetype)sharedTools {
    static NetworkTools *tools;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        /**
         NSURL *baseURL = [NSURL URLWithString:@"http://example.com/v1/"];
         [NSURL URLWithString:@"foo" relativeToURL:baseURL];// http://example.com/v1/foo
         [NSURL URLWithString:@"foo?bar=baz" relativeToURL:baseURL];// http://example.com/v1/foo?bar=baz
         [NSURL URLWithString:@"/foo" relativeToURL:baseURL];/ http://example.com/foo
         [NSURL URLWithString:@"foo/" relativeToURL:baseURL];// http://example.com/v1/foo
         [NSURL URLWithString:@"/foo/" relativeToURL:baseURL];// http://example.com/foo/
         [NSURL URLWithString:@"http://example2.com/" relativeToURL:baseURL];// http://example2.com/
         */
        tools = [[self alloc] init];
        
        // 设置反序列化格式
        tools.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    
    return tools;
}


/**
 *  请求网络的方法
 *
 *  @param method     GET /POST
 *  @param URLString  URLString
 *  @param parameters 参数
 *  @param finished   完成的回调
 */
- (void)request:(XNRequestMethod)method URLString:(NSString *)URLString parameters:(id) parameters finished:XNRequesCallBack {
    
    NSString *methodName = (method == GET) ? @"GET" : @"POST";
    
    
    //dataTaskWithHTTPMethod 本来没有实现,但是父类实现了
    [[self dataTaskWithHTTPMethod:methodName URLString:URLString parameters:parameters uploadProgress:nil downloadProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        finished(responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        finished(nil,error);
    }] resume];
    
    
    //判断请求方式
//    if (method == GET) {
//        // GET
//        [self GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            finished(responseObject, nil);
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            finished(nil,error);
//        }];
//    } else {
//        [self POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            finished(responseObject, nil);
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            finished(nil,error);
//        }];
//    }
}
#pragma mark - 天气相关的方法
/**
 *  天气相关的方法
 *
 *  @param city     城市
 *  @param province 省份
 *  @param finished 回调
 *
 *  - see [http://api.mob.com/#/mobapi/weather](http://api.mob.com/#/mobapi/weather)
 */
- (void) loadWeatherWithCity:(NSString *)city province:(NSString *)province finished:XNRequesCallBack {
    
    NSString *appKey = @"10557a5d75b9c";
    NSString *URLString = @"http://apicloud.mob.com/v1/weather/query";
    NSDictionary *parameters = @{@"key":appKey,
                                 @"city":city,
                                 @"province":province};
    
    [self request:GET URLString:URLString parameters:parameters finished:finished];

}


@end
