//
//  XNProfileController.m
//  NICHelper
//
//  Created by mac on 16/3/4.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNProfileController.h"
#import "XNColor.h"
#import <Masonry.h>




@interface XNProfileController ()

@property (nonatomic, strong) UITableViewHeaderFooterView *headerView;

@end

@implementation XNProfileController


- (void)viewDidLoad {
    [super viewDidLoad];
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.height.equalTo(@(136));
    }];

}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"profile_Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = @(indexPath.row).stringValue;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    static NSString *ID = @"header_view";
    self.headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (self.headerView == nil) {
        self.headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:ID];
    }
    self.headerView.contentView.backgroundColor = [UIColor redColor];
    return self.headerView;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 136;
}

@end
