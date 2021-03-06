//
//  XNComposeController.m
//  NICHelper
//
//  Created by mac on 16/4/10.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNComposeController.h"
#import "NetworkTools.h"
#import <Masonry.h>
#import "UIView+Extension.h"

@interface XNComposeController ()<UITextViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) UITextField *titleView;
@property (strong, nonatomic) UITextView *contentView;
@property (strong, nonatomic) UIView *LineView;
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) NSString *contentString;


@end

@implementation XNComposeController


- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
 
    
    //注册通知,监听键盘弹出事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    self.title = @"Tips";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style: UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(composeTips)];
    self.navigationItem.rightBarButtonItem.enabled = NO;

}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {

    if (self.titleView.text.length) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    } else {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    self.titleString = textField.text;
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    if ([textView.text isEqualToString:@"请输入正文"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length < 1) {
        textView.text = @"请输入正文";
        textView.textColor = [UIColor grayColor];
    }
}

- (void)textViewDidChange:(UITextView *)textView {

    self.contentString = textView.text;
    
}

#pragma mark - UIAlertViewDelegate
//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self resignFirstResponder];
        // 等待键盘的隐藏动画完成之后
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }

}


- (void)setupUI {
    
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.LineView];
    [self.view addSubview:self.contentView];
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(self.mas_topLayoutGuideBottom).offset(20);
        make.height.equalTo(@(30));
    }];
    
    [self.LineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.titleView);
        make.top.equalTo(self.titleView.mas_bottom).offset(5);
        make.height.equalTo(@(1));
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.titleView);
        make.top.equalTo(self.LineView.mas_bottom).offset(5);
        make.bottom.equalTo(self.view).offset(-20);
        
    }];
    
    
}


//回调方法
- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    //取出键盘动画的时间
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //取出键盘最后的frame
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //计算控制器的view需要平移的距离
    CGFloat deltaY = [UIScreen mainScreen].bounds.size.height - keyboardFrame.size.height;
    [UIView animateWithDuration:duration animations:^{
        
        self.view.height = deltaY;
    }];
    //设置windows的颜色
    self.view.window.backgroundColor = self.view.backgroundColor;
}



#pragma mark - 私有方法
- (void)back {
    
    UIAlertView *alerView = [[UIAlertView alloc]initWithTitle:nil message:@"确定要放弃此次编辑" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alerView.tag = 0;
    [alerView show];
    
}

- (void)composeTips {
    
    [[NetworkTools sharedTools]composeTipsWithTitle:self.titleString content:self.contentString from:@"NIC" finished:^(id result, NSError *error) {
        
        //根据回调判断是否发布成功
        // HUD
        
    }];
}

#pragma mark - 懒加载
- (UITextField *)titleView {
    if (_titleView == nil) {
        _titleView = [[UITextField alloc]init];
        _titleView.delegate = self;
        _titleView.placeholder = @"请输入标题";
    }
    
    return _titleView;
}

- (UIView *)LineView {
    if (_LineView == nil) {
        _LineView = [[UIView alloc]init];
        _LineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _LineView;
}

- (UITextView *)contentView {
    if (_contentView == nil) {
        _contentView = [[UITextView alloc]init];
        _contentView.delegate = self;
        _contentView.textColor = [UIColor grayColor];
        _contentView.font = [UIFont systemFontOfSize:16];
        _contentView.text = @"请输入正文";
    }
    return _contentView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//销毁观察者
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
