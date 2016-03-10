//
//  AppDelegate.m
//  NICHelper
//
//  Created by mac on 16/3/7.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "AppDelegate.h"
#import "XNMainTabBarViewController.h"
#import "XNColor.h"
#import "XNLoginController.h"
#import <UMSocial.h>
#import <UMSocialWechatHandler.h>
#import <UMSocialQQHandler.h>
#import <UMSocialSinaSSOHandler.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //0.设置友盟AppKey
    [UMSocialData setAppKey:@"56dfe2a467e58e8423002a33"];
    //如果不添加下面的代码，则分享列表中不会出现对应的图标
    //微信
    [UMSocialWechatHandler setWXAppId:@"wxbd8c38aecb15b5ac" appSecret:@"af9fd89ac79b446225280054df7d50b4" url:@"http://www.umeng.com/social"];
    // QQ
    [UMSocialQQHandler setQQWithAppId:@"1105241256" appKey:@"HwpE6vKKoQfe8Dhg" url:@"http://www.umeng.com/social"];
    //新浪
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"2344169185"
                                              secret:@"11a8007451fb9ce6a12b5da7d98bee99"
                                         RedirectURL:@"http://www.baidu.com"];
    
    
    //1. 创建窗口
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[XNMainTabBarViewController alloc]init];
    
    //3. 设置 self.window为主窗口并显示出来
    [self.window makeKeyAndVisible];

    [self setNavigationStyle];
    [self setStatusBarStyle:application];
    return YES;
}

//系统回调方法
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}

- (void)setNavigationStyle {
    //获取设置外观对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    //颜色太浅
//    navBar.barStyle = UIBarStyleBlack;
    //设置导航栏颜色
    [navBar setBarTintColor:DEFAULT_NAVBAR_COLOR];
    
    //设置导航栏文字为白色
    //富文本
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    
    [navBar setTitleTextAttributes:dict];
    
    [navBar setTintColor:[UIColor whiteColor]];
    
}

//统一设置状态栏外观
- (void)setStatusBarStyle:(UIApplication *)application {
    application.statusBarHidden = NO;
    
    application.statusBarStyle = UIStatusBarStyleLightContent;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  
}

- (void)applicationWillTerminate:(UIApplication *)application {

}

@end
