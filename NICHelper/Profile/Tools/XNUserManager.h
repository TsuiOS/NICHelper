//
//  XNUserManager.h
//  NICHelper
//
//  Created by mac on 16/4/1.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVUser.h>
typedef void (^XNResultBlock)(BOOL succeeded, NSError *error);

@interface XNUserManager : NSObject


/** 管理用户登录注册 */
@property (nonatomic, strong) AVUser *avuser;


+ (XNUserManager *)defaultManager;

- (void)registerWithUserName:(NSString *)userName password:(NSString *)password finished:(XNResultBlock)block;

/**
 *  退出登录
 */
- (void)logoutProcedure;


@end
