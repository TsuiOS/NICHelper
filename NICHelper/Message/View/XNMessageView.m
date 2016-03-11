//
//  XNMessageView.m
//  NICHelper
//
//  Created by mac on 16/3/8.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNMessageView.h"
#import "XNColor.h"
#import "Masonry.h"
#import "UIView+Extension.h"
#import "NSString+XNTool.h"
#import "XNMessage.h"

#define TEXTFONT [UIFont systemFontOfSize:16]
#define kMargin 10
#define kIcomWH 40


@interface XNMessageView ()

@property (nonatomic, strong) UILabel *sourceLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIImageView *iconView;

@end


@implementation XNMessageView

#pragma mark - 懒加载
- (UILabel *)sourceLabel {
    if (_sourceLabel == nil) {
        _sourceLabel = [[UILabel alloc]init];
        _sourceLabel.text = @"来自 网络中心";
        _sourceLabel.font = [UIFont systemFontOfSize:13];
        _sourceLabel.textColor = kColorBlackLight;
        
    }
    return _sourceLabel;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"我是标题";
        _titleLabel.font = TEXTFONT;
        _titleLabel.textColor = kColorBlack;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}
- (UILabel *)detailLabel {
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.text = @"haahhahhaha";
        _detailLabel.font = [UIFont systemFontOfSize:14];
        _detailLabel.textColor = kColorBlackLight;
        _detailLabel.numberOfLines = 0;
    }
    return _detailLabel;
    
}
- (UIImageView *)iconView {
    
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc]init];
        _iconView.image = [UIImage imageNamed:@"avatar_default_big"];
        _iconView.layer.cornerRadius = 20;
        _iconView.layer.masksToBounds = YES;
        [_iconView sizeToFit];
    }
    return _iconView;
}

- (instancetype)initWithFrame:(CGRect)frame {
   self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

#pragma mark - 设置子控件的数据以及布局
- (void)setMessage:(XNMessage *)message {

    _message = message;

    self.sourceLabel.text = [NSString stringWithFormat:@"来自 %@",message.source];
    self.titleLabel.text = message.title;
    self.detailLabel.text = message.detail;
    
    //计算标题的 Frame
    CGFloat viewW = [UIScreen mainScreen].bounds.size.width - 2 *kMargin;
    CGFloat maxW = viewW - 3 * kMargin - kIcomWH;
    CGSize textSize = [self.message.title sizeWithText:self.titleLabel.text font:TEXTFONT maxSize:CGSizeMake(maxW, MAXFLOAT)];
    
    //更新约束
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(textSize.width));
        make.height.equalTo(@(textSize.height + 1));
    }];
    [_detailLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kMargin);
        make.bottom.equalTo(self.mas_bottom).offset(-kMargin);
    }];
    
    
}
#pragma mark - 设置子控件的布局
- (void)setupUI {

    //1. 设置 view 的样式
    self.backgroundColor = kColorWhite;
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    
    //2.添加控件
    [self addSubview:self.sourceLabel];
    [self addSubview:self.iconView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.detailLabel];
    
    // 自动布局
    //来源标签
    [_sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(kMargin);
        make.left.equalTo(self.mas_left).offset(kMargin);
    }];
    // 用户图像
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(kMargin);
        make.right.equalTo(self.mas_right).offset(-kMargin);
        make.width.equalTo(@(kIcomWH));
        make.height.equalTo(@(kIcomWH));
    }];
    //标题
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sourceLabel.mas_bottom).offset(kMargin);
        make.left.equalTo(self.sourceLabel.mas_left);
    }];
    //详情
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sourceLabel.mas_left);
        make.right.equalTo(self.iconView.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kMargin);
        make.bottom.equalTo(self.mas_bottom).offset(-kMargin);
        
    }];
}



@end
