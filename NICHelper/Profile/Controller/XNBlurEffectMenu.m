//
//  XNBlurEffectMenu.m
//  NICHelper
//
//  Created by mac on 16/3/30.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNBlurEffectMenu.h"
#import "XNColor.h"
#import "UIButton+Extension.h"
#import <UMSocial.h>
#import <AVOSCloudSNS.h>
#import <LeanCloudSocial/AVUser+SNS.h>
#import "XNProgressHUD.h"
#import "XNUserManager.h"

#define kLoginW     DEFAULT_WIDTH * 0.8
#define kLoginX     (DEFAULT_WIDTH - kLoginW) / 2
#define kLoginH     44

// 通知字符串定义
NSString *const kQQLoginNotification = @"kQQLoginNotification";

@interface XNBlurEffectMenu ()

/** QQ登录按钮 */
@property (nonatomic, strong) UIButton *QQLogin;
/** 微信登录按钮 */
@property (nonatomic, strong) UIButton *weChatLogin;

@property (nonatomic, strong) XNUserManager *manager;

@end

@implementation XNBlurEffectMenu


- (XNUserManager *)manager {

    if (!_manager) {
        _manager = [[XNUserManager alloc]init];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置背景颜色
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    //设置毛玻璃效果
    [self setupView];
    
    // 添加手势
    [self addGesture];
    
}

- (void)addGesture {

    //• UITapGestureRecognizer(敲击)
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapOnBackground)];
    [self.view addGestureRecognizer:tapGesture];
    //• UISwipeGestureRecognizer(轻扫)
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(didTapOnBackground)];
    // 上下滑动
    [swipeGesture setDirection:UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionDown];
    [self.view addGestureRecognizer:swipeGesture];


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
    
    // 4. 创建子控件
    UIButton *QQLogin = [UIButton creatWithImageName:@"qq" title:@"QQ登录" backgroundColor:XNColor(67, 158, 241, 1)];
    [QQLogin addTarget:self action:@selector(QQLoginClick) forControlEvents:UIControlEventTouchUpInside];
    QQLogin.frame = CGRectMake(kLoginX, -300, kLoginW, kLoginH);
    self.QQLogin = QQLogin;
    
    UIButton *weChatLogin = [UIButton creatWithImageName:@"appwx_logo" title:@"微信登录" backgroundColor: XNColor(83, 209, 14, 1)];
    [weChatLogin addTarget:self action:@selector(weChatLoginClick) forControlEvents:UIControlEventTouchUpInside];
    weChatLogin.frame = CGRectMake(kLoginX, CGRectGetMaxY(QQLogin.frame) + 20, kLoginW, kLoginH);
    self.weChatLogin = weChatLogin;
    
    [self.view addSubview:QQLogin];
    [self.view addSubview:weChatLogin];
    
    
    // 自定义 button 出现动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1.0                                  //动画时长
                              delay:0.2                                  //延迟时间
             usingSpringWithDamping:1.0                                  //弹力洗漱
              initialSpringVelocity:10.0                                 //初始速度
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             
            [QQLogin setFrame:CGRectMake(kLoginX, DEFAULT_HEIGTH / 2, kLoginW, kLoginH)];
            [weChatLogin setFrame:CGRectMake(kLoginX, CGRectGetMaxY(QQLogin.frame) + 20, kLoginW, kLoginH)];
            
        } completion:nil];
        
    });
    
}

#pragma mark - private method
- (void)didTapOnBackground {
    
    [UIView animateWithDuration:1.0
                          delay:0.2
         usingSpringWithDamping:1.0
          initialSpringVelocity:10.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.QQLogin.frame = CGRectMake(kLoginX, -300, kLoginW, kLoginH);
                         self.weChatLogin.frame = CGRectMake(kLoginX, CGRectGetMaxY(self.QQLogin.frame) + 20, kLoginW, kLoginH);
                     } completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];

    });

}

- (void)QQLoginClick {
    
    [AVOSCloudSNS setupPlatform:AVOSCloudSNSQQ withAppKey:@"1105241256" andAppSecret:@"HwpE6vKKoQfe8Dhg" andRedirectURI:nil];
   
    [AVOSCloudSNS loginWithCallback:^(id object, NSError *error) {
        if (error) {
            NSLog(@"授权失败");
        } else {
            NSLog(@"%@",object);
            
            NSDictionary *userDict = @{@"username":object[@"username"],
                                       @"iconURL":object[@"avatar"]};
            // 发布通知
            [[NSNotificationCenter defaultCenter] postNotificationName:kQQLoginNotification object:@(YES) userInfo:userDict];
            [self dismissViewControllerAnimated:YES completion:nil];
//            //注册用户
//            [self.manager registerWithUserName:object[@"username"] password:object[@"avatar"]finished:^(BOOL succeeded, NSError *error) {
//                if ([self filterError:error]) {
//                    
//                }
//                //注册失败
//            }];

        }
    } toPlatform:AVOSCloudSNSQQ];
    

}
- (BOOL)filterError:(NSError *)error {
    if (error) {
        [XNProgressHUD showInfoWithStatus:@"授权失败"];
        return NO;
    }
    return YES;
}

- (void)weChatLoginClick {
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        // 获取QQ用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            
            NSDictionary *userDict = @{@"username":snsAccount.userName,
                                       @"iconURL":snsAccount.iconURL};
            // 发布通知
            [[NSNotificationCenter defaultCenter] postNotificationName:kQQLoginNotification object:nil userInfo:userDict];
            
        }});
    
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
