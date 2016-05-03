//
//  XNDBTools.m
//  NICHelper
//
//  Created by mac on 16/4/14.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNDBTools.h"

@implementation XNDBTools

+ (instancetype)sharedDBTools {
    
    static XNDBTools *_instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    
    return _instance;
}


- (instancetype)init {
    
    if (self = [super init]) {
        
        // 实例化数据库队列
        NSString *dbPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        dbPath = [dbPath stringByAppendingPathComponent:@"message.db"];
        
        // 创建数据库队列,如果不存在就会自动生成数据库文件
        _queue = [[FMDatabaseQueue alloc] initWithPath:dbPath];
        
        [self creatTables];
        
    }
    
    return self;
}

/** 创建数据表 */

- (void)creatTables {

    [self.queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
       
        BOOL result = NO;
        
        //创建信息表
        result = [db executeUpdate:@"CREATE TABLE T_Message ( id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,source TEXT,title TEXT,detail TEXT,time TEXT)"];
        
        if (!result) {
            NSLog(@"创建数据表失败");
            *rollback = YES;
            return ;
        }
    }];
}

@end
