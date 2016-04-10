//
//  XNProgressHUD.m
//  NICHelper
//
//  Created by mac on 16/3/16.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNProgressHUD.h"

@implementation XNProgressHUD


+ (void)show {
    
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD show];
    
    
}
+ (void)dismiss {
    [SVProgressHUD dismiss];
}
+ (void)showInfoWithStatus:(NSString *)string {
    [SVProgressHUD showInfoWithStatus:string];
}
+ (void)showErrorWithStatus:(NSString *)string {
    [SVProgressHUD showErrorWithStatus:string];
}

@end
