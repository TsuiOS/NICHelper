//
//  XNProfileDetailCell.m
//  NICHelper
//
//  Created by mac on 16/3/18.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNProfileDetailCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>

@interface XNProfileDetailCell ()

@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *userIDLabel;
@property (nonatomic, strong) UIImageView *avatarImageView;

@end


@implementation XNProfileDetailCell

#pragma mark - 懒加载
- (UILabel *)userNameLabel {
    if (_userNameLabel == nil) {
        _userNameLabel = [[UILabel alloc]init];
        _userNameLabel.text = @"";
        
    }
    return _userNameLabel;
}
- (UILabel *)userIDLabel {
    if (_userIDLabel == nil) {
        _userIDLabel = [[UILabel alloc]init];
        _userIDLabel.text = @"";
        _userIDLabel.textColor = [UIColor grayColor];
        _userIDLabel.font = [UIFont systemFontOfSize:14];
        
    }
    return _userIDLabel;
}

- (UIImageView *)avatarImageView {

    if (_avatarImageView == nil) {
        _avatarImageView = [[UIImageView alloc]init];
//        [_avatarImageView setImage:[UIImage imageNamed:@"avatar_default_big"]];
        _avatarImageView.layer.cornerRadius = 30;
        _avatarImageView.layer.masksToBounds = YES;
    }
    return _avatarImageView;
}

+ (instancetype)tableViewCellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"message_cell";
    
    XNProfileDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XNProfileDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.avatarImageView];
        [self addSubview:self.userNameLabel];
        [self addSubview:self.userIDLabel];
    }
    
    return self;
}

- (void)layoutSubviews {
    
    [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(self).offset(15);
        make.width.equalTo(@(60));
        make.height.equalTo(@(60));
    }];
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarImageView);
        make.left.equalTo(self.avatarImageView.mas_right).offset(15);
    }];
    [_userIDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.avatarImageView.mas_bottom);
        make.left.equalTo(self.userNameLabel);
    }];

}

- (void)setUserDict:(NSDictionary *)userDict {
    
    _userDict = userDict;    
    self.userNameLabel.text = userDict[@"username"];
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:userDict[@"iconURL"]] placeholderImage:[UIImage imageNamed:@"avatar_default_big"]];

}


@end
