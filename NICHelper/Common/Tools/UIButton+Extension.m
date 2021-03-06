//
//  UIButton+Extension.m
//  NICHelper
//
//  Created by mac on 16/3/30.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

+ (UIButton *)creatWithTitle:(NSString *)title
                 backgroundColor:(UIColor *)color {

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundColor:color];
    [button setTintColor:[UIColor whiteColor]];
    
    // 调整 image 和 title 之间的间距
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    
    return button;
}

- (void)setHighlighted:(BOOL)highlighted {}

@end
