//
//  UITextField+Extension.h
//  NICHelper
//
//  Created by mac on 16/4/10.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Extension)

+ (UITextField *)creatWithPlaceholder:(NSString *)placeholder target:(id)target;

@end


@interface UITextView (Extension)

+ (UITextView *)creatWithPlaceholder:(NSString *)placeholder target:(id)target;

@end