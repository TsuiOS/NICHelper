//
//  XNComposeController.m
//  NICHelper
//
//  Created by mac on 16/4/10.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNComposeController.h"
#import "NetworkTools.h"

@interface XNComposeController ()<UITextViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleView;
@property (weak, nonatomic) IBOutlet UITextView *contentView;
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) NSString *contentString;


@end

@implementation XNComposeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Tips";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_back_normal"] style: UIBarButtonItemStylePlain target:self action:@selector(back)];

     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(composeTips)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    [self.titleView becomeFirstResponder];
    self.titleView.delegate = self;
    self.contentView.delegate = self;
    self.contentView.text = @"请输入正文";
    self.contentView.textColor = [UIColor grayColor];
    
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
- (void)back {
    
    [self resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)composeTips {
    
    NSLog(@"%@",self.titleString);
    NSLog(@"%@",self.contentString);
    
    [[NetworkTools sharedTools]composeTipsWithTitle:self.titleString content:self.contentString from:@"NIC" finished:^(id result, NSError *error) {
        
        //根据回调判断是否发布成功
        // HUD
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
