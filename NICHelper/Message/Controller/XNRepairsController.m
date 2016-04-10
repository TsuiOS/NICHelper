//
//  XNRepairsController.m
//  NICHelper
//
//  Created by mac on 16/4/10.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNRepairsController.h"
#import "NetworkTools.h"
#import <Masonry.h>
#import "UITextField+Extension.h"
#import "XNProgressHUD.h"


@interface XNRepairsController ()<UITextViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UITextView *titleView;
@property (nonatomic, strong) UITextField *addressView;
@property (nonatomic, strong) UITextField *phoneView;
@property (nonatomic, strong) UITextField *numberView;
@property (nonatomic, strong) UITextField *studentNameView;
@property (nonatomic, strong) UITextView *reasonView;

@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) NSString *addressString;
@property (nonatomic, strong) NSString *phoneString;
@property (nonatomic, strong) NSString *numberString;
@property (nonatomic, strong) NSString *studentNameString;
@property (nonatomic, strong) NSString *reasonString;


@end

@implementation XNRepairsController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"在线报修";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_back_normal"] style: UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(composeClick)];
    self.navigationItem.rightBarButtonItem.enabled = NO;


    [self setupUI];
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    if (textView == self.titleView) {
        if ([textView.text isEqualToString:@"请输入故障描述"]) {
            textView.text = @"";
            textView.textColor = [UIColor blackColor];
        }
    } else {
        if ([textView.text isEqualToString:@"请输入故障原因,若不知道可不填"]) {
            textView.text = @"";
            textView.textColor = [UIColor blackColor];
        }
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    if (textView == self.titleView) {
        if (textView.text.length < 1) {
            textView.text = @"请输入故障描述";
            textView.textColor = [UIColor grayColor];
        }
    } else {
        if ([textView.text isEqualToString:@"请输入故障原因,若不知道可不填"]) {
            textView.text = @"";
            textView.textColor = [UIColor blackColor];
        }
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    
    if (textView == self.titleView) {
        self.titleString = textView.text;
    } else {
        self.reasonString = textView.text;
    }
    
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (self.addressView.text.length) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    } else {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    
    if (textField == self.studentNameView) {
        self.studentNameString = textField.text;
    } else if (textField == self.phoneView) {
        if (textField.text.length == 0) {
            [XNProgressHUD showErrorWithStatus:@"请输入联系方式"];
            return;
        }
        self.phoneString = textField.text;
    } else if (textField == self.numberView) {
        if (textField.text.length == 0) {
            [XNProgressHUD showErrorWithStatus:@"请输入上网账号"];
            return;
        }
        self.numberString = textField.text;
    } else if (textField == self.addressView) {
        if (textField.text.length == 0) {
            [XNProgressHUD showErrorWithStatus:@"请输入地址"];
            return;
        }
        self.addressString = textField.text;
    }

    
}
#pragma mark - 私有方法


- (void)back {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)composeClick {
    
    [[NetworkTools sharedTools]composeMessageWithTitle:self.titleString
                                               address:self.addressString
                                                 phone:self.phoneString
                                                number:self.numberString
                                           studentName:self.studentNameString
                                                reason:self.reasonString
                                              finished:^(id result, NSError *error) {
                                                  
                                                  
        
        NSLog(@"%@",result);
    }];
    
}

- (void)setupUI {
    
    
    // UITextView 居上
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.studentNameView];
    [self.view addSubview:self.phoneView];
    [self.view addSubview:self.addressView];
    [self.view addSubview:self.numberView];
    [self.view addSubview:self.reasonView];
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(self.mas_topLayoutGuideBottom).offset(20);
        make.height.equalTo(@(100));
    }];
    
    [self.studentNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView.mas_bottom).offset(10);
        make.right.and.left.equalTo(self.titleView);
        make.height.equalTo(@(30));
    }];
    
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.studentNameView.mas_bottom).offset(10);
        make.right.and.left.equalTo(self.titleView);
        make.height.equalTo(@(30));
    }];
    [self.numberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneView.mas_bottom).offset(10);
        make.right.and.left.equalTo(self.titleView);
        make.height.equalTo(@(30));
    }];
    [self.addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.numberView.mas_bottom).offset(10);
        make.right.and.left.equalTo(self.titleView);
        make.height.equalTo(@(30));
    }];
    [self.reasonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addressView.mas_bottom).offset(10);
        make.right.and.left.equalTo(self.titleView);
        make.height.equalTo(@(100));
    }];

}

#pragma mark - 懒加载

- (UITextView *)titleView {
    
    if (_titleView == nil) {
        _titleView = [UITextView creatWithPlaceholder:@"请输入故障描述"
                                               target:self];
    }
    return _titleView;
}

- (UITextField *)numberView {
    
    if (_numberView == nil) {
        _numberView = [UITextField creatWithPlaceholder:@"请输入上网账号(不可为空)"
                                               target:self];
        _numberView.keyboardType = UIKeyboardTypeASCIICapable;
    }
    return _numberView;
}

- (UITextField *)addressView {
    if (_addressView == nil) {
        _addressView = [UITextField creatWithPlaceholder:@"请输入地址(不可为空)"
                                                  target:self];
    }
    
    return _addressView;
    
}

- (UITextField *)phoneView {
    
    if (_phoneView == nil) {
        _phoneView = [UITextField creatWithPlaceholder:@"请输入联系方式(不可为空)"
                                                target:self];
        _phoneView.keyboardType = UIKeyboardTypePhonePad;


    }
    return _phoneView;
}

- (UITextField *)studentNameView {
    
    if (_studentNameView == nil) {
        _studentNameView = [UITextField creatWithPlaceholder:@"请输入姓名"
                                                      target:self];
        
    }
    return _studentNameView;
    
}
- (UITextView *)reasonView {
    
    if (_reasonView == nil) {
        _reasonView = [UITextView creatWithPlaceholder:@"请输入故障原因,若不知道可不填"
                                                target:self];

    }
    return _reasonView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
