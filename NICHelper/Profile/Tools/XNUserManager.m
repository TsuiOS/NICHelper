//
//  XNUserManager.m
//  NICHelper
//
//  Created by mac on 16/4/1.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNUserManager.h"

@implementation XNUserManager

static XNUserManager *_defaultManager = nil;

+ (XNUserManager *)defaultManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultManager = [[self alloc]init];
    });
    return _defaultManager;

}

- (instancetype)init {
    if (self = [super init]) {
        self.avuser = [AVUser user];
    }
    return self;
}

typedef void (^XNResultBlock)(BOOL succeeded, NSError *error);

#pragma mark - 注册的方法
- (void)registerWithUserName:(NSString *)userName password:(NSString *)password finished:(XNResultBlock)block{

    self.avuser.username = userName;
    self.avuser.password = password;
    self.avuser.email = @"";
    self.avuser.mobilePhoneNumber = @"";
    
    [self.avuser signUpInBackgroundWithBlock:block];
    
}

#pragma mark - 退出登录

- (void)logoutProcedure {

}

@end
