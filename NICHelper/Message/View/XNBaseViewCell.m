//
//  XNBaseViewCell.m
//  NICHelper
//
//  Created by mac on 16/4/12.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNBaseViewCell.h"


#import "XNMessageView.h"
#import "XNColor.h"
#import <Masonry.h>
#import "UIView+Extension.h"

@interface XNBaseViewCell ()

@property (nonatomic, strong) XNMessageView *messageView;

@end


@implementation XNBaseViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        //取消 cell 点击显示灰色的效果
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        XNMessageView *messageView = [[XNMessageView alloc]init];
        // 添加控件
        [self.contentView addSubview:messageView];
        self.messageView = messageView;
    }
    
    return self;
}

/**
 *  重写子控件的布局
 */
- (void)layoutSubviews {
    
    
    [super layoutSubviews];
    
    self.messageView.message = self.message;
    
    // 自动布局
    UIEdgeInsets padding = UIEdgeInsetsMake(5, 20, 5, 0);
    [self.messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(padding);
        
    }];
    
    
}


@end