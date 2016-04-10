//
//  UIButton+Extension.h
//  NICHelper
//
//  Created by mac on 16/3/30.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

/**
 *  创建自定义的 UIButton
 *
 *  @param imageName            图片名
 *  @param title                title
 *  @param backgroundColor      背景颜色
 *
 *  @return 自定义的 UIButton
 */
+ (UIButton *)creatWithTitle:(NSString *)title
                 backgroundColor:(UIColor *) color;

@end
