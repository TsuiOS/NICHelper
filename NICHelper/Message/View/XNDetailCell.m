//
//  XNDetailCell.m
//  NICHelper
//
//  Created by mac on 16/4/12.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNDetailCell.h"
#import "XNColor.h"
#import <Masonry.h>
#define TEXTFONT [UIFont systemFontOfSize:16]
#define kMargin 10
#define kIcomWH 40

@interface XNDetailCell ()

@property (nonatomic, strong) UILabel *sourceLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIImageView *iconView;

@end

@implementation XNDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //添加控件
        [self addSubview:self.sourceLabel];
        [self addSubview:self.iconView];
        [self addSubview:self.detailLabel];
        
    }
    return self;
}

/** 重新布局子控件 */
- (void)layoutSubviews {

    [super layoutSubviews];
    
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
    //详情
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sourceLabel.mas_left);
        make.right.equalTo(self.iconView.mas_left);
//        make.top.equalTo(self.titleLabel.mas_bottom).offset(kMargin);
        make.bottom.equalTo(self.mas_bottom).offset(-kMargin);
        
    }];

    
}

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

@end
