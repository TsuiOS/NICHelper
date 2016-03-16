//
//  XNProgressHUD.m
//  NICHelper
//
//  Created by mac on 16/3/16.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNProgressHUD.h"

@implementation XNProgressHUD


+ (void)show:(UIColor *)backgroundColor {
    
    if (backgroundColor == nil) {
        [SVProgressHUD show];
    } else {
        [SVProgressHUD setBackgroundColor:backgroundColor];
        [SVProgressHUD show];
    }
    
}
+ (void)dismiss {
    [SVProgressHUD dismiss];
}
+ (void)showInfoWithStatus:(NSString *)string {
    [SVProgressHUD showInfoWithStatus:string];
}

@end
