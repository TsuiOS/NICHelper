//
//  XNDetailViewController.m
//  NICHelper
//
//  Created by mac on 16/3/15.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNDetailViewController.h"
#import "NetworkTools.h"
#import "XNDetailCell.h"

@interface XNDetailViewController ()<XNDetailCellDelegate>

@property (nonatomic, strong) XNDetailCell *tempCell;

@end



@implementation XNDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"详情/更新";
    [[NetworkTools sharedTools] updateMessageWithFinish:1 result:@"失败" finishName:@"宁" progress:@"已完成" uid:@"33" finished:^(id result, NSError *error) {
        NSLog(@"%@",result);
    }];
    
    [self.tableView registerClass:[XNDetailCell class] forCellReuseIdentifier:NSStringFromClass([XNDetailCell class])];
    self.tableView.estimatedRowHeight = 200.0f;
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XNDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XNDetailCell class]) forIndexPath:indexPath];
    
    [cell setDetailMessage:self.detailMessage indePath:indexPath];
    cell.delegate = self;
    return cell;
}

#pragma mark - UITableViewDelegate 

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (!_tempCell) {
        _tempCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XNDetailCell class])];
    }
    
    XNMessage *message = self.detailMessage;
    
    // 判断高度是否计算过
    if (message.cellHeight <= 0) {
        //填充数据
        [_tempCell setDetailMessage:message indePath:indexPath];
        // 根据当前数据,计算 cell 的高度
        message.cellHeight = [_tempCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
    }
    
    return message.cellHeight;

}


#pragma mark - XNDetailCellDelegate

- (void)detailCell:(XNDetailCell *)cell switchExpandedStateWithIndexPath:(NSIndexPath *)index {

    // 改变数据
    XNMessage *message = self.detailMessage;
    message.expanded = ! message.expanded;
    message.cellHeight = 0;
    
    // 刷新数据
    [self.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationFade];

}

@end
