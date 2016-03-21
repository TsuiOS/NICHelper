//
//  XNLocationController.h
//  NICHelper
//
//  Created by mac on 16/3/20.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XNLocationController :UIViewController

// 定义一个块代码的属性，block属性需要用 copy
@property (nonatomic, copy) void (^completion)(NSString *province, NSString *city);
@end
