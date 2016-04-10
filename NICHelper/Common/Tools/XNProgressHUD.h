//
//  XNProgressHUD.h
//  NICHelper
//
//  Created by mac on 16/3/16.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>

@interface XNProgressHUD : SVProgressHUD


+ (void)show;

+ (void)dismiss;

+ (void)showInfoWithStatus:(NSString *)string;
+ (void)showErrorWithStatus:(NSString *)string;

@end
