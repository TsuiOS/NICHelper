//
//  XNCollectCell.m
//  NICHelper
//
//  Created by mac on 16/4/12.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNCollectCell.h"
#import "XNMessageView.h"
#import <Masonry.h>

@interface XNCollectCell ()


@end

@implementation XNCollectCell



- (void)layoutSubviews {
    
    // 很重要
    [super layoutSubviews];
    
    for (UIView *view in self.contentView.subviews) {

        if ([view isKindOfClass:[XNMessageView class]]) {
            view.layer.cornerRadius = 0;
            UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
            [view mas_updateConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self).insets(padding);
 
            }];
            
        }
    }
    

}

@end
