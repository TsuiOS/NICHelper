//
//  XNMessage.h
//  NICHelper
//
//  Created by mac on 16/3/7.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XNMessage : NSObject
/** 来源 */
@property (nonatomic, copy) NSString *source;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 详情 */
@property (nonatomic, copy) NSString *detail;

+ (instancetype)messageWithDict:(NSDictionary *)dict;

+ (NSArray *)message;

@end
