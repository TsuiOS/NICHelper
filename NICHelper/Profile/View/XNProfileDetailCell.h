//
//  XNProfileDetailCell.h
//  NICHelper
//
//  Created by mac on 16/3/18.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XNProfileDetailCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *userDict;

+ (instancetype)tableViewCellWithTableView:(UITableView *)tableView;

@end
