//
//  XNMessageController.m
//  NICHelper
//
//  Created by mac on 16/3/4.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNMessageController.h"
#import "XNDetailViewController.h"
#import "XNMessageCell.h"
#import "XNColor.h"
#import "XNMessage.h"
#import "ShareManager.h"
#import "UIView+Extension.h"
#import "XNRefreshControl.h"

@interface XNMessageController () <UITableViewDelegate>

@property (nonatomic, strong) NSArray *message;

@end

@implementation XNMessageController

#pragma mark 懒加载数据
- (NSArray *)message {
    if (_message == nil) {
        _message = [XNMessage message];
    }
    return _message;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.refreshControl = [XNRefreshControl new];
    [self configTableView];
    
    
}
// tableView 的相关设置
- (void)configTableView {
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setBackgroundImage:[UIImage imageNamed:@"barbuttonicon_add"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addMessage) forControlEvents:UIControlEventTouchUpInside];
    //设置尺寸
    addButton.size = addButton.currentBackgroundImage.size;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:addButton];
    // 设置背景颜色
    self.view.backgroundColor = [UIColor clearColor]; //DEFAULT_BACKGROUND_COLOR;
    //设置 cell 的高度
    self.tableView.rowHeight = 180;
    //取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

// 发布任务的按钮
- (void)addMessage {
    NSLog(@"%s",__FUNCTION__);

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.message.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    XNMessageCell *cell = [XNMessageCell tableViewCellWithTableView:tableView];
    cell.messageView.message = self.message[indexPath.row];

    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark UITableViewDelegate   
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XNDetailViewController *detailVC = [[XNDetailViewController alloc]init];
    
    [[self navigationController]pushViewController:detailVC animated:YES];

}

// cell 左划效果
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    /**
     UITableViewRowActionStyleDefault = 0,
     UITableViewRowActionStyleDestructive = UITableViewRowActionStyleDefault,
     UITableViewRowActionStyleNormal
     */
    UITableViewRowAction *sharedAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"    " handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //相关逻辑
        [self UMSharedToPlatform];

        // 在最后希望cell可以自动回到默认状态，所以需要退出编辑模式
        tableView.editing = NO;
        NSLog(@"分享");
    }];
    UITableViewRowAction *likeAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"     " handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"收藏");
        // 在最后希望cell可以自动回到默认状态，所以需要退出编辑模式
        tableView.editing = NO;
    }];
    //换成图片最简单的方式,但是需要素材合适
//    settingAction.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"barbuttonicon_Operate"]];
    likeAction.backgroundColor = [UIColor clearColor];
    sharedAction.backgroundColor = [UIColor clearColor];
    return @[likeAction,sharedAction];

}
/**
 *  友盟分享
 */
- (void)UMSharedToPlatform {
    // 分享的图片
    UIImage *shareImage = [UIImage imageNamed:@"Action_Share"];
    // 分享文字
    NSString *shareText = @"你要分享的文字";
    [ShareManager shareToPlatform:self shareText:shareText shareImage:shareImage delegate:nil];
}



@end
