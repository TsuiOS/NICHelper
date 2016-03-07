//
//  XNMainTabBarViewController.m
//  NICHelper
//
//  Created by mac on 16/3/4.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNMainTabBarViewController.h"
#import "XNBaseNavigationController.h"
#import "XNMessageController.h"
#import "XNComposeController.h"
#import "XNProfileController.h"

#define XNColor [UIColor colorWithRed:223 / 255.0 green:107 / 255.0 blue:93 /255.0 alpha:1.0]

@interface XNMainTabBarViewController ()

@end

@implementation XNMainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化子控制器
    [self addSubControllers];
    
}

/**
 *  初始化所有自控制器
 */
- (void)addSubControllers {
    
    //任务
    XNMessageController *message = [[XNMessageController alloc]init];
    [self setupChildViewController:message title:@"任务" imageName: @"tabbar_mainframe" selectedImageName:@"tabbar_mainframeHL"];
    
    //撰写
    UIViewController *placeholderView = [[UIViewController alloc]init];
    placeholderView.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:placeholderView];
    
    //个人中心
    XNProfileController *profile = [[XNProfileController alloc]init];
    [self setupChildViewController:profile title:@"我" imageName: @"tabbar_me" selectedImageName:@"tabbar_meHL"];

}
/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    
    //1.设置子控制器的文字
    childVc.title = title;
    //设置文字样式
    NSMutableDictionary *selectedTextAttrs = [[NSMutableDictionary alloc]init];
    selectedTextAttrs[NSForegroundColorAttributeName] =  XNColor;   //223 107 93
    
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    
    //2.设置图标
    childVc.tabBarItem.image = [[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置选中状态的图标
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //3.包装成一个导航控制器
    XNBaseNavigationController *nav = [[XNBaseNavigationController alloc]initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
    
}




@end
