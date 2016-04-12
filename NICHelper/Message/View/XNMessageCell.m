//
//  XNMessageCell.m
//  NICHelper
//
//  Created by mac on 16/3/7.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNMessageCell.h"
#import "XNMessageTool.h"


@interface XNMessageCell ()



@end

@implementation XNMessageCell



// These methods can be used by subclasses to animate additional changes to the cell when the cell is changing state
// Note that when the cell is swiped, the cell will be transitioned into the UITableViewCellStateShowingDeleteConfirmationMask state,
// but the UITableViewCellStateShowingEditControlMask will not be set.
// 用户某一行开始侧滑, 并且侧滑的button还没展示出来时, state的值为UITableViewCellStateShowingDeleteConfirmationMask

- (void)willTransitionToState:(UITableViewCellStateMask)state {
    
    [super willTransitionToState:state];

}

- (void)didTransitionToState:(UITableViewCellStateMask)state {
    
    for (UIView *subview in self.subviews) {
        if ([NSStringFromClass([subview class]) isEqualToString:@"UITableViewCellDeleteConfirmationView"] ) {
            
            UIView *likeView = (UIView *)[subview.subviews firstObject];
            UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
            likeButton.frame = likeView.bounds;
            [likeButton setImage:[UIImage imageNamed:@"icon_tabbar_like"] forState:UIControlStateNormal];
            [likeButton setImage:[UIImage imageNamed:@"icon_tabbar_like_active"] forState:UIControlStateSelected];
            // 控制收藏按钮的状态
            likeButton.selected = [XNMessageTool isCollected:self.message];
            
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


}

- (void)likeBtnClick:(UIButton *)button {
    
    if (button.isSelected) { // 已经被收藏,现在需要取消收藏
        [XNMessageTool unCollect:self.message];
    } else { // 没有被收藏,现在需要收藏
        [XNMessageTool collect:self.message];
    
    }
    button.selected = !button.selected;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableview setEditing:NO animated:YES];
    });

}




@end
