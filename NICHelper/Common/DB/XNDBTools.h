//
//  XNDBTools.h
//  NICHelper
//
//  Created by mac on 16/4/14.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>

@interface XNDBTools : NSObject

+ (instancetype)shardDBTools;

/** 数据库操作队列 */

@property (nonatomic, strong) FMDatabaseQueue *queue;

/** 把网络请求的新数据 */
+ (void)saveItemWithDict:(NSDictionary *)dict;
/** 获取所有数据 */
+ (NSArray *)list;
/** 分页展示数据 */
+ (NSArray *)listWithRange:(NSRange)rang;
/** 查询本地是否存在 */
+ (BOOL)isExistWithID:(NSString *)idStr;

@end
