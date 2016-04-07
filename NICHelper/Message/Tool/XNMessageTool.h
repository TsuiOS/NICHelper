//
//  XNMessageTool.h
//  NICHelper
//
//  Created by mac on 16/4/7.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XNMessage;


@interface XNMessageTool : NSObject

/** 收藏任务 */
+ (void)collect:(XNMessage *)message;

/** 取消收藏任务 */
+ (void)unCollect:(XNMessage *)message;

/** 判断某个任务是否收藏 */
+ (BOOL)isCollected:(XNMessage *)message;

/** 返回用户收藏的所有团购 */
+ (NSArray *)collectedMessage;




@end
