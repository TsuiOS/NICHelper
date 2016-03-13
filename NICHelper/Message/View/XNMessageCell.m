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
    self.backgroundColor = [UIColor clearColor];
    
    XNMessageView *messageView = [[XNMessageView alloc]init];
    
    // 添加控件
    [self.contentView addSubview:messageView];
    self.messageView = messageView;
    // 自动布局
    UIEdgeInsets padding = UIEdgeInsetsMake(5, 10, 5, 10);
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

// These methods can be used by subclasses to animate additional changes to the cell when the cell is changing state
// Note that when the cell is swiped, the cell will be transitioned into the UITableViewCellStateShowingDeleteConfirmationMask state,
// but the UITableViewCellStateShowingEditControlMask will not be set.
// 用户某一行开始侧滑, 并且侧滑的button还没展示出来时, state的值为UITableViewCellStateShowingDeleteConfirmationMask
// 但是由于侧滑的view 是懒加载的, 这个时候还没创建出来, 所以使用延时加载
/**
 UITableViewCellStateDefaultMask                     = 0,
 UITableViewCellStateShowingEditControlMask          = 1 << 0,
 UITableViewCellStateShowingDeleteConfirmationMask   = 1 << 1
 */
- (void)willTransitionToState:(UITableViewCellStateMask)state {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (UIView *subview in self.subviews) {
            if ([NSStringFromClass([subview class]) isEqualToString:@"UITableViewCellDeleteConfirmationView"] ) {
                
                UIView *setView = (UIView *)[subview.subviews firstObject];
                UIImageView *setImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"barbuttonicon_set"]];
                // 需要转换坐标
                CGPoint childSetP = [setView.superview convertPoint:setView.center toView:setView];
                setImage.center = childSetP;
                [setView addSubview:setImage];
                
                
                UIView *sharedview = (UIView *)[subview.subviews lastObject];
                UIImageView *sharedImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"barbuttonicon_Operate"]];
                // 需要转换坐标
                CGPoint childSP = [sharedview.superview convertPoint:sharedview.center toView:sharedview];
                sharedImage.center = childSP;
                [sharedview addSubview:sharedImage];
            }
        }
    });

}
- (void)didTransitionToState:(UITableViewCellStateMask)state {

}



@end
