//
//  XNWeatherModel.m
//  NICHelper
//
//  Created by mac on 16/3/13.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNWeatherModel.h"
#import "NetworkTools.h"
#import <YYModel/YYModel.h>

@implementation XNFuture



@end

@implementation XNResult


@end

@implementation XNWeatherModel


+ (void)weatherWithSuccess:(void(^)(NSDictionary *weatherDict))success {
    
    [[NetworkTools sharedTools] loadWeatherWithCity:@"聊城" province:@"山东" finished:^(id result, NSError *error) {
        
        if (error) {
            NSLog(@"网络错误");
            return ;
        }
        if (success) {
            success((NSDictionary *)[XNWeatherModel yy_modelWithDictionary:result]);
        }
    }];
}

@end
