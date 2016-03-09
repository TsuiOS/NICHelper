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
#import <UMSocial.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //0.设置友盟AppKey
    [UMSocialData setAppKey:@"56dfe2a467e58e8423002a33"];
    //1. 创建窗口
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[XNMainTabBarViewController alloc]init];
    
    //3. 设置 self.window为主窗口并显示出来
    [self.window makeKeyAndVisible];

    [self setNavigationStyle];
    [self setStatusBarStyle:application];
    return YES;
}
- (void)setNavigationStyle {
    //获取设置外观对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    //设置导航栏图片
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
