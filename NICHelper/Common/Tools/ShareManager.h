//
//  ShareManager.h
//  NICHelper
//
//  Created by mac on 16/3/13.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareManager : NSObject


+ (void)shareToPlatform:(UIViewController *)controller shareText:(NSString *)shareText shareImage:(UIImage *)shareImage delegate:(id)delegate;
@end
