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
#import <AFNetworkActivityIndicatorManager.h>
#import <UMSocial.h>
#import <UMSocialWechatHandler.h>
#import <UMSocialQQHandler.h>
#import <UMSocialSinaSSOHandler.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <AVOSCloud.h>
#import <AVOSCloudSNS.h>



@interface AppDelegate () {

    BMKMapManager* _mapManager;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //1. 创建窗口
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[XNMainTabBarViewController alloc]init];
    
    //3. 设置 self.window为主窗口并显示出来
    [self.window makeKeyAndVisible];
    
    // 显示网络指示符
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    [self setNavigationStyle];
    [self setStatusBarStyle:application];
    [self setUMShare];
    
    //请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"9TFBUgqfqDkNkBjGEBS5y9Zj" generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    return YES;
}

// 统一设置NavigationStyle
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

// 设置相关的 appkey
- (void)setUMShare {
    
    
    [AVOSCloud setApplicationId:@"GqBvABDwSuDar68lH0EivqMG" clientKey:@"ySnAYTO5niWSetWW6qBXFE0Y"];
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

    
    /**
     由于苹果审核政策需求，建议大家对未安装客户端平台进行隐藏，在设置QQ、微信AppID之后调用下面的方法，[UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline]]; 这个接口只对默认分享面板平台有隐藏功能，自定义分享面板或登录按钮需要自己处理
     */
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToWechatSession, UMShareToQzone, UMShareToQQ, UMShareToSina, UMShareToWechatTimeline]];
    
}


-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [AVOSCloudSNS handleOpenURL:url];
}

// When Build with IOS 9 SDK
// For application on system below ios 9
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [AVOSCloudSNS handleOpenURL:url];
}
// For application on system equals or larger ios 9
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    return [AVOSCloudSNS handleOpenURL:url];
}

@end
