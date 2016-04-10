//
//  UITextField+Extension.m
//  NICHelper
//
//  Created by mac on 16/4/10.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)

+ (UITextField *)creatWithPlaceholder:(NSString *)placeholder target:(id)target {

    UITextField *textField = [[UITextField alloc]init];
    
    textField.delegate = target;
    textField.placeholder = placeholder;
    textField.font = [UIFont systemFontOfSize:16];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    return textField;
}

@end


@implementation UITextView (Extension)

+ (UITextView *)creatWithPlaceholder:(NSString *)placeholder target:(id)target {
    
    UITextView *textView = [[UITextView alloc]init];
    
    textView.delegate = target;
    textView.text = placeholder;
    textView.textColor = [UIColor grayColor];
    textView.font = [UIFont systemFontOfSize:16];
    
    return textView;
}

@end