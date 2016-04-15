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

@end
