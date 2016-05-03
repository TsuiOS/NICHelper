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
#import "XNComposeController.h"
#import "XNBaseNavigationController.h"

@interface XNMessageController () <UITableViewDelegate,UIPopoverPresentationControllerDelegate>

@property (nonatomic, strong) NSArray *message;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) XNPopViewController *menuView;
@property (nonatomic, strong) UIButton *addButton;
// 记录页数
@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation XNMessageController
static NSString *ID = @"message_cell";

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
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addMessage:) name:kDismissNotification object:nil];
    
}
// 刷新
- (void)refreshCustom {
    // 下拉刷新
    __weak typeof(self) weakSelf = self;
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewMessage];
    }];
    
    [header setTitle:@"我不耐烦,我要的我现在就要" forState:MJRefreshStateIdle];
    [header setTitle:@"我不耐烦,我要的我现在就要" forState:MJRefreshStatePulling];
    [header setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    
    //设置 header
    self.tableView.mj_header = header;
    //上拉加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self loadMoreMessage];
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
    self.tableView.backgroundColor = [UIColor clearColor]; //DEFAULT_BACKGROUND_COLOR;
    // 注册 cell
    [self.tableView registerClass:[XNMessageCell class] forCellReuseIdentifier:ID];
    //设置 cell 的高度   
    self.tableView.rowHeight = 180;
    self.tableView.contentInset = UIEdgeInsetsMake(0, -10, 0, 0);
    //取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    

}

#pragma mark - 私有方法

// 下拉刷新
- (void)loadNewMessage {


}

// 上拉加载
- (void)loadMoreMessage {


}

// 发布任务的按钮
- (void)addMessage {
    
    self.menuView = [[XNPopViewController alloc]init];
    //初始化
    self.menuView.modalPresentationStyle = UIModalPresentationPopover;
    
    UIPopoverPresentationController *popVC = self.menuView.popoverPresentationController;
    //设置代理
    popVC.delegate = self;
    popVC.sourceView = self.addButton;
    popVC.sourceRect = CGRectMake(0, 5, self.addButton.width, self.addButton.height);
 
    //退出视图
    [self presentViewController:self.menuView animated:YES completion:nil];
    

}

- (void)addMessage:(NSNotification *)notification {
    
    // 由通知把跳转控制器以字符串传过来,这边把字符串转换成类
    NSString *targetClassName = notification.userInfo[@"viewControllerName"];
    
    Class targetClass = NSClassFromString(targetClassName);
    
    UIViewController *desVC = [targetClass new];
    
    XNBaseNavigationController *nvc = [[XNBaseNavigationController alloc]initWithRootViewController:desVC];
    [self presentViewController:nvc animated:YES completion:nil];
    
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.message.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    XNMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.message = self.message[indexPath.row];
    cell.tableview = tableView;
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark UITableViewDelegate   
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XNDetailViewController *detailVC = [[XNDetailViewController alloc]init];
    
    detailVC.detailMessage = self.message[indexPath.row];
    
    [[self navigationController] pushViewController:detailVC animated:YES];

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
    }];
    UITableViewRowAction *likeAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"    " handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    
    //换成图片最简单的方式,但是需要素材合适
//    likeAction.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"barbuttonicon_Operate"]];
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


- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
