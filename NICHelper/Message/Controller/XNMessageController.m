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
#import <UMSocial.h>
#import <UMSocialQQHandler.h>
#define XNAPPKEY @"56dfe2a467e58e8423002a33"

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
    // 设置背景颜色
    self.view.backgroundColor = [UIColor clearColor]; //DEFAULT_BACKGROUND_COLOR;
    //设置 cell 的高度
    self.tableView.rowHeight = 180;
    //取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 进入编辑模式
//    [self setEditing:YES animated:YES];
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
/**
 *  测试代码
 */
// 允许移动表格
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;

}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    /**
    NSUInteger fromRow = [sourceIndexPath row];
    NSUInteger toRow = [destinationIndexPath row];
    
    id object = [self.message objectAtIndex:fromRow];
    [self.message removeObjectAtIndex:fromRow];
    [self.message insertObject:object atIndex:toRow];
     */
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark UITableViewDelegate   
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
    UITableViewRowAction *settingAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"    " handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"设置");
        // 在最后希望cell可以自动回到默认状态，所以需要退出编辑模式
        //tableView.editing = NO;
    }];
    //换成图片最简单的方式,但是需要素材合适
//    settingAction.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"barbuttonicon_Operate"]];
    settingAction.backgroundColor = [UIColor clearColor];//DEFAULT_BACKGROUND_COLOR;
    sharedAction.backgroundColor = [UIColor clearColor];//DEFAULT_BACKGROUND_COLOR;
    return @[settingAction,sharedAction];

}
/**
 *  友盟分享
 */
- (void)UMSharedToPlatform {
    
    // 指定分享平台
    NSArray *sharedPlatform = [NSArray arrayWithObjects:UMShareToSina,UMShareToQzone,UMShareToSms,UMShareToQQ,UMShareToWechatSession,UMShareToWechatTimeline,nil];
    // 分享的图片
    UIImage *shareImage = [UIImage imageNamed:@"Action_Share"];
    // 分享文字
    NSString *shareText = @"你要分享的文字";
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:XNAPPKEY
                                      shareText:shareText
                                     shareImage:shareImage
                                shareToSnsNames:sharedPlatform
                                       delegate:nil];
}


@end
