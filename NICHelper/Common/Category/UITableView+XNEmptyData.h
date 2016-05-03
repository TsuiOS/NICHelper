//
//  UITableView+XNEmptyData.h
//  NICHelper
//
//  Created by mac on 16/5/3.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (XNEmptyData)

- (void)tableViewDisplayWithMsg:(NSString *)message ifNecessaryForRowCount:(NSUInteger) rowCount;


@end
