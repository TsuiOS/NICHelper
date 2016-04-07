//
//  XNMessage.h
//  NICHelper
//
//  Created by mac on 16/3/7.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XNMessage : NSObject<NSCoding>
/** 来源 */
@property (nonatomic, copy) NSString *source;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 详情 */
@property (nonatomic, copy) NSString *detail;
/** 时间 */
@property (nonatomic, copy) NSString *time;

+ (instancetype)messageWithDict:(NSDictionary *)dict;

+ (NSArray *)message;



@end
