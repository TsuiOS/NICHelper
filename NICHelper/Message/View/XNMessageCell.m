//
//  XNMessageCell.m
//  NICHelper
//
//  Created by mac on 16/3/7.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNMessageCell.h"
#import "XNColor.h"
#import "Masonry.h"
#import "XNMessageView.h"


@interface XNMessageCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIImageView *iconView;

@end

@implementation XNMessageCell

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
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        // 添加控件
        [self.contentView addSubview:_titleLabel];
        //    [self.contentView addSubview:_detailLabel];
        //    [self.contentView addSubview:_iconView];
        
        self.backgroundColor = kColorWhite;
        // 自动布局
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.top.equalTo(self.mas_top).offset(10);
            make.right.equalTo(self.mas_right).offset(100);
            make.height.equalTo(@(21));
        }];
        

    }
    
    return self;
}
#pragma mark 设置 cell 的布局
- (void)setupUI {
    // 添加控件
    [self.contentView addSubview:_titleLabel];
//    [self.contentView addSubview:_detailLabel];
//    [self.contentView addSubview:_iconView];
    
    self.backgroundColor = kColorWhite;
    // 自动布局
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(self.mas_top).offset(10);
        make.right.equalTo(self.mas_right).offset(100);
        make.height.equalTo(@(21));
    }];
    

}
+ (instancetype)tableViewCellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"message_cell";
    
    XNMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XNMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
