//
//  XNComposeHeaderView.m
//  NICHelper
//
//  Created by mac on 16/4/11.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNComposeHeaderView.h"
#import <QuartzCore/QuartzCore.h>

#import <Masonry.h>


@interface XNComposeHeaderView ()<UITextViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic) UITextField *titleView;
@property (strong, nonatomic) UITextView *tipsView;
@property (strong, nonatomic) UIView *LineView;
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) NSString *contentString;

@end

@implementation XNComposeHeaderView


//+ (instancetype)composeHeaderWithTableView:(UITableView *)tableView {
//
//    static NSString *ID = @"composeHeader_view";
//    XNComposeHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
//    if (headerView == nil) {
//        headerView = [[XNComposeHeaderView alloc]initWithReuseIdentifier:ID];
//    }
//
//    return headerView;
//}

//- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
//
//    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
//        [self addSubview:self.tipsView];
//        [self addSubview:self.titleView];
//    }
//    return self;
//    
//}

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.tipsView];
        [self addSubview:self.titleView];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(self).offset(20);
        make.height.equalTo(@(30));
    }];
    
    [self.LineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self.titleView.mas_bottom).offset(5);
        make.height.equalTo(@(4));
    }];
    
    [self.tipsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.titleView);
        make.top.equalTo(self.LineView).offset(2);
        make.bottom.equalTo(self).offset(-20);
        
    }];

}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
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
        _LineView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _LineView.layer.borderWidth = 1;
    }
    return _LineView;
}

- (UITextView *)tipsView {
    if (_tipsView == nil) {
        _tipsView = [[UITextView alloc]init];
        _tipsView.delegate = self;
        _tipsView.textColor = [UIColor grayColor];
        _tipsView.font = [UIFont systemFontOfSize:16];
        _tipsView.text = @"请输入正文";
    }
    return _tipsView;
}

@end
