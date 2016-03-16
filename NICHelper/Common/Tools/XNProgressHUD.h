//
//  XNProgressHUD.h
//  NICHelper
//
//  Created by mac on 16/3/16.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>

@interface XNProgressHUD : SVProgressHUD

/**
 *  XNProgressHUD
 *
 *  @param setBackgroundColor default is [UIColor whiteColor]
 */
+ (void)show:(UIColor *)backgroundColor;

+ (void)dismiss;

+ (void)showInfoWithStatus:(NSString *)string;

@end
