//
//  XNMessage.h
//  NICHelper
//
//  Created by mac on 16/3/7.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XNMessage : NSObject

@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detail;

+ (instancetype)messageWithDict:(NSDictionary *)dict;
+ (NSArray *)message;

@end
