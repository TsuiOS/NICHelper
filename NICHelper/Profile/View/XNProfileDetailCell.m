//
//  XNProfileDetailCell.m
//  NICHelper
//
//  Created by mac on 16/3/18.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNProfileDetailCell.h"

@interface XNProfileDetailCell ()

@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *userIDLabel;
@property (nonatomic, strong) UIImageView *avatarImageView;

@end


@implementation XNProfileDetailCell


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


}


@end
