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

@property (nonatomic, strong) XNMessageView *messageView;


@end

@implementation XNMessageCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setupUI];

    }
    
    return self;
}
#pragma mark 设置 cell 的布局
- (void)setupUI {
    //取消 cell 点击显示灰色的效果
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = XNColor(224, 231, 234, 1);
    XNMessageView *messageView = [[XNMessageView alloc]init];
    // 添加控件
    [self.contentView addSubview:messageView];
    self.messageView = messageView;
    // 自动布局
    UIEdgeInsets padding = UIEdgeInsetsMake(10, 10, 5, 10);
    [self.messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(padding);

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
