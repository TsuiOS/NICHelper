//
//  XNCollectController.m
//  NICHelper
//
//  Created by mac on 16/3/18.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNCollectController.h"
#import "XNMessageTool.h"
#import "XNTableViewCell.h"
#import "XNColor.h"

@interface XNCollectController ()

/** 存放收藏的任务 */
@property (nonatomic, strong) NSMutableArray *collectMessage;

@end

@implementation XNCollectController

static NSString * const ID = @"collect_cell";

#pragma mark - 懒加载

- (NSMutableArray *)collectMessage {
    if (_collectMessage == nil) {
        _collectMessage = [NSMutableArray array];
    }
    return _collectMessage;
}

#pragma mark - 初始化

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    // 设置背景颜色
    self.view.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    // 注册 cell
    [self.tableView registerClass:[XNTableViewCell class] forCellReuseIdentifier:ID];
    //设置 cell 的高度
    self.tableView.rowHeight = 180;
    //取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 移除收据
    [self.collectMessage removeAllObjects];
    // 添加数据
    [self.collectMessage addObjectsFromArray:[XNMessageTool collectedMessage]];
    // 刷新数据
    [self.tableView reloadData];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",self.collectMessage);
     self.navigationItem.rightBarButtonItem = self.editButtonItem;

}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.collectMessage.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    XNTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.message = self.collectMessage[indexPath.row];
    
    return cell;
}

/** 默认可编辑 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //取消收藏
    [XNMessageTool unCollect:self.collectMessage[indexPath.row]];
    // 修改模型
    [self.collectMessage removeObjectAtIndex:indexPath.row];
    // 刷新表格
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}




@end
