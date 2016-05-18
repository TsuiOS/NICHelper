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


#define baseURL  [NSURL URLWithString:@"http://219.231.178.42/:3000/api/user/"]

@implementation NetworkTools

+ (instancetype)sharedTools {
    static NetworkTools *tools;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        /**
         NSURL *baseURL = [NSURL URLWithString:@"http://example.com/v1/"];
         [NSURL URLWithString:@"foo" relativeToURL:baseURL];                  // http://example.com/v1/foo
         [NSURL URLWithString:@"foo?bar=baz" relativeToURL:baseURL];          // http://example.com/v1/foo?bar=baz
         [NSURL URLWithString:@"/foo" relativeToURL:baseURL];                 // http://example.com/foo
         [NSURL URLWithString:@"foo/" relativeToURL:baseURL];                 // http://example.com/v1/foo
         [NSURL URLWithString:@"/foo/" relativeToURL:baseURL];                // http://example.com/foo/
         [NSURL URLWithString:@"http://example2.com/" relativeToURL:baseURL]; // http://example2.com/
         */
        tools = [[self alloc]initWithBaseURL:baseURL];
        
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
    [[self dataTaskWithHTTPMethod:methodName
                        URLString:URLString
                       parameters:parameters
                   uploadProgress:nil
                 downloadProgress:nil
                          success:^(NSURLSessionDataTask *task, id responseObject) {
      
                              finished(responseObject, nil);
                              
                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                              finished(nil,error);
        
//                              NSLog(@"error--%@",error);
                          }] resume];
    
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
    NSURL *URL = [NSURL URLWithString:@"http://apicloud.mob.com/v1/weather/query" relativeToURL:baseURL]; // http://apicloud.mob.com/v1/weather/query

    NSString *URLString = [URL absoluteString];

    NSDictionary *parameters = @{@"key":appKey,
                                 @"city":city,
                                 @"province":province};
    
    [self request:GET URLString:URLString parameters:parameters finished:finished];

}

- (void)loadUserInfoWithToken:(NSString *)tokenString finished:XNRequesCallBack {
   
    
    NSString *URLString = [[NSURL URLWithString:@"info" relativeToURL:baseURL] absoluteString];

    
    [self request:POST URLString:URLString parameters:@{@"token":tokenString} finished:finished];


}

/**
 *  发布 Tips
 *
 *  @param title    标题
 *  @param content 内容
 *  @param from    来源
 */
- (void)composeTipsWithTitle:(NSString *)title content:(NSString *)content from:(NSString *)from finished:XNRequesCallBack {
    
    NSDictionary *params = @{@"title":title,
                             @"content":content,
                             @"from":from};

    NSString *URLString = [[NSURL URLWithString:@"tips/sav" relativeToURL:baseURL] absoluteString];

    [self request:POST URLString:URLString parameters:params finished:XNRequesCallBack];
}
   
/**
 *  发布任务
 *
 *  @param title       标题
 *  @param address     地址
 *  @param phone       电话
 *  @param number      账号
 *  @param studentName 姓名
 *  @param reason      原因(可空)
 */
- (void)composeMessageWithTitle:(NSString *)title
                        address:(NSString *)address
                          phone:(NSString *)phone
                         number:(NSString *)number
                    studentName:(NSString *)studentName
                         reason:(NSString *)reason
                       finished:XNRequesCallBack {

    NSDictionary *params = @{@"title":title,
                             @"address":address,
                             @"phone":phone,
                             @"number":number,
                             @"student_name":studentName,
                             @"reason":reason};
    
    NSString *URLString = [[NSURL URLWithString:@"tasks/save" relativeToURL:baseURL] absoluteString];
    
    [self request:POST URLString:URLString parameters:params finished:XNRequesCallBack];
    
}

/**
 *  更新维系进度
 *
 *  @param finish     是否完成 1 完成 0 未完成
 *  @param result     故障原因
 *  @param finishName 完成人员
 *  @param progress   维修进度  稍后出发  正在路上 已完成
 */
- (void)updateMessageWithFinish:(NSInteger)finish result:(NSString *)result finishName:(NSString *)finishName progress:(NSString *)progress uid:(NSString *)uid finished:XNRequesCallBack{
    
    NSDictionary *params = @{@"finish":@(finish),
                             @"result":result,
                             @"finish_name":finishName,
                             @"progress":progress,
                             @"uid":uid};
    
    NSString *URLString = [[NSURL URLWithString:@"tasks/update" relativeToURL:baseURL] absoluteString];
    
    [self request:POST URLString:URLString parameters:params finished:XNRequesCallBack];
}



@end
