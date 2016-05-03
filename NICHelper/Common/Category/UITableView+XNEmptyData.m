//
//  UITableView+XNEmptyData.m
//  NICHelper
//
//  Created by mac on 16/5/3.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "UITableView+XNEmptyData.h"

@implementation UITableView (XNEmptyData)


- (void)tableViewDisplayWithMsg:(NSString *)message ifNecessaryForRowCount:(NSUInteger)rowCount
{
    if (rowCount == 0) {
        // Display a message when the table is empty
        // 没有数据的时候，UILabel的显示样式
        UILabel *messageLabel = [UILabel new];
        
        messageLabel.text = message;
        messageLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        messageLabel.textColor = [UIColor lightGrayColor];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        [messageLabel sizeToFit];
        
        self.backgroundView = messageLabel;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    } else {
        self.backgroundView = nil;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
}

@end
