//
//  XNBlurEffectMenu.m
//  NICHelper
//
//  Created by mac on 16/3/30.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNBlurEffectMenu.h"
#import "XNColor.h"
#import <Masonry.h>
#import "UIButton+Extension.h"
#import <UMSocial.h>

@interface XNBlurEffectMenu ()

///** QQ登录按钮 */
//@property (nonatomic, strong) UIButton *QQLogin;
///** 微信登录按钮 */
//@property (nonatomic, strong) UIButton *weChatLogin;

@end

@implementation XNBlurEffectMenu


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置背景颜色
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    //设置毛玻璃效果
    [self setupView];
    
}

#pragma mark - 设置毛玻璃效果

- (void)setupView {
    
    //  1. 创建UIBlurEffect类的实例，并指定某一种毛玻璃效果。
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    /**
     2. 创建UIVisualEffectView类的实例，
     将步骤1中的UIBlurEffect类的实例应用到UIVisualEffectView类的实例上。
     */
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    visualEffectView.frame = self.view.bounds;
    // 设置透明度
    visualEffectView.alpha = 0.6f;
    
    // 3. 将UIVisualEffectView类的实例置于待毛玻璃化的视图之上即可。
    [self.view addSubview:visualEffectView];
    
    UIButton *QQLogin = [UIButton creatWithImageName:@"qq" title:@"QQ登录" backgroundColor:XNColor(67, 158, 241, 1)];
    [QQLogin addTarget:self action:@selector(QQLoginClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *weChatLogin = [UIButton creatWithImageName:@"appwx_logo" title:@"微信登录" backgroundColor: XNColor(83, 209, 14, 1)];
    [weChatLogin addTarget:self action:@selector(weChatLoginClick) forControlEvents:UIControlEventTouchUpInside];
    // 4. 创建子控件
    [self.view addSubview:QQLogin];
    [self.view addSubview:weChatLogin];
    
    CGFloat loginW = DEFAULT_WIDTH * 0.8;
    CGFloat loginH = 44;
    
    [weChatLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_centerY).offset(-10);
        make.width.equalTo(@(loginW));
        make.height.equalTo(@(loginH));
    }];
    
    [QQLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_centerY).offset(10);
        make.width.equalTo(@(loginW));
        make.height.equalTo(@(loginH));

    }];
    
}

- (void)QQLoginClick {
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        // 获取QQ用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            
            
            NSDictionary *userDict = @{@"username":snsAccount.userName,
                                       @"iconURL":snsAccount.iconURL};
            [[NSNotificationCenter defaultCenter] postNotificationName:kQQLoginNotification object:nil userInfo:userDict];
            
//            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
        }});
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)weChatLoginClick {
    
    NSLog(@"%s",__FUNCTION__);
}

@end
