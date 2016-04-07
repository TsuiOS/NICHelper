//
//  XNMessageTool.m
//  NICHelper
//
//  Created by mac on 16/4/7.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNMessageTool.h"
#import "XNMessage.h"

#define XNCollectFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"collect_deal.data"]

@implementation XNMessageTool

static NSMutableArray *_collectedMessage;

+ (void)initialize {
    // 从文件中读取之前收藏的任务
    // 接档
    _collectedMessage = [NSKeyedUnarchiver unarchiveObjectWithFile:XNCollectFile];
    
    // 如果是第一次收藏团购,先初始化一个可变的数组
    if (_collectedMessage == nil) {
        _collectedMessage = [NSMutableArray arrayWithCapacity:10];
    }

}

/** 收藏任务 */
+ (void)collect:(XNMessage *)message {
    
    //1.将收藏的任务查到数组的最前面
    [_collectedMessage insertObject:message atIndex:0];
    
    //2.归档
    [NSKeyedArchiver archiveRootObject:_collectedMessage toFile:XNCollectFile];

}

/** 取消收藏任务 */
+ (void)unCollect:(XNMessage *)message {
    
    //1.移除任务
    [_collectedMessage removeObject:message];
    
    //2. 归档
    [NSKeyedArchiver archiveRootObject:_collectedMessage toFile:XNCollectFile];

}

/** 判断某个任务是否收藏 */
+ (BOOL)isCollected:(XNMessage *)message {

    return [_collectedMessage containsObject:message];
}

+ (NSArray *)collectedMessage {
    
    return _collectedMessage;

}


@end
