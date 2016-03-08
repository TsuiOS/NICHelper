//
//  XNMessageController.m
//  NICHelper
//
//  Created by mac on 16/3/4.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNMessageController.h"
#import "XNMessageCell.h"
#import "XNColor.h"
#import "XNMessage.h"

@interface XNMessageController ()

@property (nonatomic, strong) NSMutableArray *message;

@end

@implementation XNMessageController

#pragma mark 懒加载数据
- (NSMutableArray *)message {
    if (_message == nil) {
        _message = [XNMessage message];
    }
    return _message;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置背景颜色
    self.view.backgroundColor = XNColor(224, 231, 234, 1);
    //设置 cell 的高度
    self.tableView.rowHeight = 180;
    //取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.message.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    XNMessageCell *cell = [XNMessageCell tableViewCellWithTableView:tableView];
    cell.messageView.message = self.message[indexPath.row];

    return cell;
}


@end
