//
//  XNMessage.m
//  NICHelper
//
//  Created by mac on 16/3/7.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNMessage.h"

@implementation XNMessage

+ (instancetype)messageWithDict:(NSDictionary *)dict; {
    id obj = [[self alloc]init];
    [obj setValuesForKeysWithDictionary:dict];
    return obj;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

+ (NSArray *)message {
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"Message.plist" ofType:nil];
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:filePath];
    
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:dictArray.count];
    
    //遍历
    [dictArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XNMessage *message = [self messageWithDict:obj];
        [arrayM addObject:message];
    }];
    
    return [arrayM copy];
}
@end
