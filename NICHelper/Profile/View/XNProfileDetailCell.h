//
//  XNProfileDetailCell.h
//  NICHelper
//
//  Created by mac on 16/3/18.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XNUserInfoModel.h"

@interface XNProfileDetailCell : UITableViewCell

@property (nonatomic, strong) XNUserInfoModel *userInfo;

+ (instancetype)tableViewCellWithTableView:(UITableView *)tableView;

@end
