//
//  XNMessageView.m
//  NICHelper
//
//  Created by mac on 16/3/8.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNMessageView.h"
#import "XNColor.h"

@interface XNMessageView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIImageView *iconView;
@end


@implementation XNMessageView

#pragma mark 懒加载
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 44, 21)];
        _titleLabel.text = @"我是标题";
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = kColorBlack;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}
- (UILabel *)detailLabel {
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.text = @"我是内容";
        _detailLabel.font = [UIFont systemFontOfSize:14];
        _detailLabel.textColor = kColorBlackLight;
        _detailLabel.numberOfLines = 0;
    }
    return _detailLabel;
    
}
- (UIImageView *)iconView {
    
    if (_iconView == nil) {
        _iconView.image = [UIImage imageNamed:@"avatar_default_big"];
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
//布局子空间
- (void)setupUI {
    self.backgroundColor = kColorWhite;
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;

}


@end
