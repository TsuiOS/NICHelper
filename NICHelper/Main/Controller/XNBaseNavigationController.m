//
//  XNBaseNavigationController.m
//  NICHelper
//
//  Created by mac on 16/3/4.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNBaseNavigationController.h"
#import "XNColor.h"

@interface XNBaseNavigationController ()

@end

@implementation XNBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DEFAULT_BACKGROUND_COLOR;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    if (self.viewControllers.count > 0) {
        
        // 自动隐藏和显示 tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
}

@end
