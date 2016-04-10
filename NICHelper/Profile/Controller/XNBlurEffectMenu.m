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

@interface XNBlurEffectMenu ()<UITextFieldDelegate>

/** QQ登录按钮 */
@property (nonatomic, strong) UIButton *QQLogin;
/** 微信登录按钮 */
@property (nonatomic, strong) UIButton *tokenLogin;

@property (nonatomic, strong) UITextField *tokenText;
@property (nonatomic, strong) XNUserManager *manager;
@property (nonatomic, strong) NSString *token;

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
    UITextField *tokenText = [[UITextField alloc]init];
    [tokenText becomeFirstResponder];
    tokenText.layer.borderColor = XNColor(67, 158, 241, 1).CGColor;
    tokenText.layer.borderWidth = 1.0;
    tokenText.layer.cornerRadius = 5.0;
    tokenText.delegate = self;
    NSString *userToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    if (userToken.length) {
      tokenText.text = userToken;
    }
    tokenText.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入Token登录" attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    
    tokenText.frame = CGRectMake(kLoginX, -300, kLoginW, kLoginH);
    self.tokenText = tokenText;
    
    UIButton *tokenLogin = [UIButton creatWithTitle:@"登  录" backgroundColor: XNColor(83, 209, 14, 1)];
    [tokenLogin addTarget:self action:@selector(tokenLoginClick) forControlEvents:UIControlEventTouchUpInside];
    tokenLogin.frame = CGRectMake(kLoginX, CGRectGetMaxY(tokenText.frame) + 20, kLoginW, kLoginH);
    self.tokenLogin = tokenLogin;
    
    [self.view addSubview:tokenText];
    [self.view addSubview:tokenLogin];
    
    
    // 自定义 button 出现动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1.0                                  //动画时长
                              delay:0.2                                  //延迟时间
             usingSpringWithDamping:1.0                                  //弹力洗漱
              initialSpringVelocity:10.0                                 //初始速度
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             
            [tokenText setFrame:CGRectMake(kLoginX, DEFAULT_HEIGTH / 2 - 44, kLoginW, kLoginH)];
            [tokenLogin setFrame:CGRectMake(kLoginX, CGRectGetMaxY(tokenText.frame) + 20, kLoginW, kLoginH)];
            
        } completion:nil];
        
    });
    
}

#pragma mark - private method
- (void)didTapOnBackground {
    
    [self.tokenText resignFirstResponder];
    
    [UIView animateWithDuration:1.0
                          delay:0.2
         usingSpringWithDamping:1.0
          initialSpringVelocity:10.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.tokenText.frame = CGRectMake(kLoginX, -300, kLoginW, kLoginH);
                         self.tokenLogin.frame = CGRectMake(kLoginX, CGRectGetMaxY(self.tokenText.frame) + 20, kLoginW, kLoginH);
                     } completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];

    });

}


- (void)textFieldDidBeginEditing:(UITextField *)textField {

    
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    self.token = textField.text;
    [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [textField resignFirstResponder];
    return YES;
}
- (void)tokenLoginClick {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:kQQLoginNotification object:nil userInfo:@{@"token":self.token}];
    [self dismissViewControllerAnimated:YES completion:nil];
}






@end
