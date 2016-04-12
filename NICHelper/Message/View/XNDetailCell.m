//
//  XNDetailCell.m
//  NICHelper
//
//  Created by mac on 16/4/12.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNDetailCell.h"
#import "XNColor.h"
#import "XNMessage.h"
#import <Masonry.h>
#define TEXTFONT [UIFont systemFontOfSize:16]
#define kMargin 10
#define kIcomWH 40

@interface XNDetailCell ()

@property (nonatomic, strong) UILabel *sourceLabel;
@property (nonatomic, strong) UIButton *moreButton;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIImageView *iconView;

@property (strong, nonatomic) MASConstraint *contentHeightConstraint;
@property (nonatomic, weak) XNMessage *detailMessage;
@property (strong, nonatomic) NSIndexPath *indexPath;

@end

@implementation XNDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //取消 cell 点击显示灰色的效果
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
        
    }
    return self;
}

- (void)initView {

    //添加控件
    [self.contentView addSubview:self.sourceLabel];
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.moreButton];

    // 自动布局
    //来源标签
    [_sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(self.contentView).offset(kMargin);
        make.height.equalTo(@21);
    }];
    // 用户图像
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(kMargin);
        make.right.equalTo(self.contentView).offset(-kMargin);
        make.width.equalTo(@(kIcomWH));
        make.height.equalTo(@(kIcomWH));
    }];
    
    // 更多
    [_moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@32);
        make.left.and.right.and.bottom.equalTo(self.contentView);
    }];
    
    //详情
    // 计算 UILable 的preferredMaxLayoutWidth值,否则系统无法决定Label的宽度
    CGFloat preferredMaxLayoutWidth = DEFAULT_WIDTH - 20;
    _detailLabel.preferredMaxLayoutWidth = preferredMaxLayoutWidth;
    
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.equalTo(self.contentView).insets(UIEdgeInsetsMake(4, 10, 4, 10));
        make.top.equalTo(self.iconView.mas_bottom).offset(10);
        make.bottom.equalTo(self.moreButton.mas_top).offset(-5);
        // 先加上高度的限制
        // 优先级只设置成High,比正常的高度约束低一些,防止冲突
        _contentHeightConstraint = make.height.equalTo(@200).priorityHigh();
        
    }];


}

- (void)setDetailMessage:(XNMessage *)detailMessage indePath:(NSIndexPath *)indexPath {

    _detailMessage = detailMessage;
    _indexPath = indexPath;
    // 设置数据
    self.sourceLabel.text = [NSString stringWithFormat:@"来自: %@",detailMessage.source];
    self.detailLabel.text = detailMessage.detail;
    
    // 改变约束
    if (_detailMessage.expanded) {
        [_contentHeightConstraint uninstall];
    } else {
        [_contentHeightConstraint install];
    
    }
}


#pragma mark - Actions

- (void)switchExpandedState:(UIButton *)button {

    if ([self.delegate respondsToSelector:@selector(detailCell:switchExpandedStateWithIndexPath:)]) {
        [self.delegate detailCell:self switchExpandedStateWithIndexPath:_indexPath];
    }
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
        _detailLabel.font = [UIFont systemFontOfSize:14];
        _detailLabel.numberOfLines = 0;
        _detailLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _detailLabel.clipsToBounds = YES;
 
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

- (UIButton *)moreButton {
    if (_moreButton == nil) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreButton setTitle:@"More" forState:UIControlStateNormal];
        [_moreButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_moreButton addTarget:self action:@selector(switchExpandedState:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}


@end
