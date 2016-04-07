//
//  XNTableViewCell.m
//  NICHelper
//
//  Created by mac on 16/4/7.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNTableViewCell.h"
#import "XNMessageView.h"
#import "XNColor.h"
#import "Masonry.h"
#import "UIView+Extension.h"

@interface XNTableViewCell ()

@property (nonatomic, strong) XNMessageView *messageView;

@end
@implementation XNTableViewCell


/**
 *  重写系统的初始化方法
 */
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
    
    
    self.messageView.message = self.message;
    
    // 自动布局
    UIEdgeInsets padding = UIEdgeInsetsMake(5, 10, 5, 10);
    [self.messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(padding);
        
    }];
    
    
}

- (void)willTransitionToState:(UITableViewCellStateMask)state {
    
    [super willTransitionToState:state];
    
}

- (void)didTransitionToState:(UITableViewCellStateMask)state {
    
    [super didTransitionToState:state];
}

@end
