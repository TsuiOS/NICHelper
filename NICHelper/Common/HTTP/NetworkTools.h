//
//  NetworkTools.h
//  NICHelper
//
//  Created by mac on 16/3/12.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

/**
 请求方式枚举
 */
typedef enum : NSUInteger {
    GET,
    POST,
    
} XNRequestMethod;

@interface NetworkTools : AFHTTPSessionManager

+ (instancetype)sharedTools;

- (void)request:(XNRequestMethod)method URLString:(NSString *)URLString parameters:(id) parameters finished:(void (^)(id result, NSError *error))finished;

@end
