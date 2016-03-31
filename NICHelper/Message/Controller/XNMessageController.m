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
#import "MJRefresh.h"
#import "XNPopViewController.h"

@interface XNMessageController () <UITableViewDelegate,UIPopoverPresentationControllerDelegate>

@property (nonatomic, strong) NSArray *message;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) XNPopViewController *menuView;
@property (nonatomic, strong) UIButton *addButton;

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
    [self configTableView];
    [self refreshCustom];
    
    
}
// 刷新
- (void)refreshCustom {
    // 下拉刷新
    __weak typeof(self) weakSelf = self;
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf.tableView reloadData];
        //结束刷新
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    
    //设置 header
    self.tableView.mj_header = header;
    [header setTitle:@"我不耐烦,我要的我现在就要" forState:MJRefreshStateIdle];
    [header setTitle:@"我不耐烦,我要的我现在就要" forState:MJRefreshStatePulling];
    [header setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    
    //上拉加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        
        // 变为没有更多数据的状态
//        [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];

    self.tableView.mj_header.automaticallyChangeAlpha = YES;

}
// tableView 的相关设置
- (void)configTableView {
    
    self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addButton setBackgroundImage:[UIImage imageNamed:@"barbuttonicon_add"] forState:UIControlStateNormal];
    [self.addButton addTarget:self action:@selector(addMessage) forControlEvents:UIControlEventTouchUpInside];
    //设置尺寸
    self.addButton.size = self.addButton.currentBackgroundImage.size;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.addButton];
    // 设置背景颜色
    self.view.backgroundColor = [UIColor clearColor]; //DEFAULT_BACKGROUND_COLOR;
    //设置 cell 的高度
    self.tableView.rowHeight = 180;
    //取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

// 发布任务的按钮
- (void)addMessage {
    
    self.menuView = [[XNPopViewController alloc]init];
    //初始化
    self.menuView.modalPresentationStyle = UIModalPresentationPopover;
    
    UIPopoverPresentationController *popVC = self.menuView.popoverPresentationController;
    //设置代理
    popVC.delegate = self;
    popVC.backgroundColor = DEFAULT_NAVBAR_COLOR;
    popVC.sourceView = self.addButton;
    popVC.sourceRect = CGRectMake(0, 5, self.addButton.width, self.addButton.height);
 
    //退出视图
    [self presentViewController:self.menuView animated:YES completion:nil];
    

}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
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
    
    self.indexPath = indexPath;
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
    UITableViewRowAction *likeAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"    " handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"收藏");
        // 在最后希望cell可以自动回到默认状态，所以需要退出编辑模式
//            tableView.editing = NO;

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
    
    XNMessage *message = self.message[self.indexPath.row];
    // 分享的图片
    UIImage *shareImage = nil;
    // 分享文字
    NSString *shareText = [NSString stringWithFormat:@"%@ %@",message.title,message.detail];
    [ShareManager shareToPlatform:self shareText:shareText shareImage:shareImage delegate:nil];
}



@end
