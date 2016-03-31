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

@interface XNMessageCell ()

@end

@implementation XNMessageCell


+ (instancetype)tableViewCellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"message_cell";
    
    XNMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XNMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

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
    
    // 自动布局
    UIEdgeInsets padding = UIEdgeInsetsMake(5, 10, 5, 10);
    [self.messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(padding);
        
    }];


}

// These methods can be used by subclasses to animate additional changes to the cell when the cell is changing state
// Note that when the cell is swiped, the cell will be transitioned into the UITableViewCellStateShowingDeleteConfirmationMask state,
// but the UITableViewCellStateShowingEditControlMask will not be set.
// 用户某一行开始侧滑, 并且侧滑的button还没展示出来时, state的值为UITableViewCellStateShowingDeleteConfirmationMask
// 但是由于侧滑的view 是懒加载的, 这个时候还没创建出来, 所以使用延时加载

- (void)willTransitionToState:(UITableViewCellStateMask)state {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (UIView *subview in self.subviews) {
            if ([NSStringFromClass([subview class]) isEqualToString:@"UITableViewCellDeleteConfirmationView"] ) {
        
                UIView *likeView = (UIView *)[subview.subviews firstObject];
                UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
                likeButton.frame = likeView.bounds;
                [likeButton setImage:[UIImage imageNamed:@"icon_tabbar_like"] forState:UIControlStateNormal];
                [likeButton setImage:[UIImage imageNamed:@"icon_tabbar_like_active"] forState:UIControlStateSelected];
                [likeButton addTarget:self action:@selector(likeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                // 需要转换坐标
                CGPoint childSetP = [subview convertPoint:likeView.center toView:likeView];
                likeButton.center = childSetP;
                [likeView addSubview:likeButton];
                
           
                UIView *sharedview = (UIView *)[subview.subviews lastObject];
                UIImageView *sharedImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_tabbar_share"]];
                // 需要转换坐标
                CGPoint childSP = [subview convertPoint:sharedview.center toView:sharedview];
                sharedImage.center = childSP;
                [sharedview addSubview:sharedImage];
            }
        }
    });

}

- (void)likeBtnClick:(UIButton *)button {
    button.selected = !button.selected;

}


@end
