//
//  XNMessageCell.h
//  NICHelper
//
//  Created by mac on 16/3/7.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XNMessageView.h"

@interface XNMessageCell : UITableViewCell
@property (nonatomic, strong) XNMessageView *messageView;

+ (instancetype)tableViewCellWithTableView:(UITableView *)tableView;

@end
