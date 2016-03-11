//
//  NSString+XNTool.m
//  NICHelper
//
//  Created by mac on 16/3/8.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "NSString+XNTool.h"

@implementation NSString (XNTool)

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary * attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;

}

@end
