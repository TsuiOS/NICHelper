//
//  XNProfileDetailCell.m
//  NICHelper
//
//  Created by mac on 16/3/18.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNProfileDetailCell.h"

@implementation XNProfileDetailCell

+ (instancetype)tableViewCellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"message_cell";
    
    XNProfileDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XNProfileDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
