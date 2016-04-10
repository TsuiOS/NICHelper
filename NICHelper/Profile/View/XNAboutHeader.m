//
//  XNAboutHeader.m
//  NICHelper
//
//  Created by mac on 16/4/10.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNAboutHeader.h"

@implementation XNAboutHeader

+ (instancetype)settingAboutHeader {
    
    //加载xib
    XNAboutHeader *headerView = [[[NSBundle mainBundle] loadNibNamed:@"XNAboutHeader" owner:nil options:nil] lastObject];
    
    return headerView;
}

@end
