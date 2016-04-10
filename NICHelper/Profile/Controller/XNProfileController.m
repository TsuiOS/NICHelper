//
//  XNProfileController.m
//  NICHelper
//
//  Created by mac on 16/3/4.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNProfileController.h"
#import "XNColor.h"
#import "XNProfileCell.h"
#import "XNProfileDetailCell.h"
#import "XNBlurEffectMenu.h"
#import "XNMineViewController.h"
#import "ShareManager.h"
#import "NetworkTools.h"
#import <MJExtension.h>
#import "XNUserInfoModel.h"

@interface XNProfileController ()

@property (nonatomic, strong) NSArray *infoSettings;
@property (nonatomic, strong) NSArray *userArray;

@end

@implementation XNProfileController

#pragma mark - 创建tableView的时候默认是分组样式的
- (instancetype)init {

    return [super initWithStyle:UITableViewStyleGrouped];
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (NSArray *)infoSettings {
    if (_infoSettings == nil) {
        
        _infoSettings = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]
                                                          pathForResource:@"Profile"
                                                          ofType:@"plist"]];
    }
    
    return _infoSettings;

}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"登录" style: UIBarButtonItemStylePlain target:self action:@selector(loginClick)];

    // 注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess:) name:kQQLoginNotification object:nil];
    
}

- (void)loginSuccess:(NSNotification *)notification {
    
    
    [[NetworkTools sharedTools]loadUserInfoWithToken:notification.userInfo[@"token"] finished:^(id result, NSError *error) {
 
        self.userArray = [XNUserInfoModel mj_objectArrayWithKeyValuesArray:result];
        [self.tableView reloadData];
    }];
}

- (void)dealloc {
    // 移除注册通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)loginClick {
    
    XNBlurEffectMenu *loginMenu = [[XNBlurEffectMenu alloc]init];
    loginMenu.modalPresentationStyle = UIModalPresentationOverFullScreen;
    /**
     UIModalTransitionStyleCoverVertical    底部向上 默认的动画方式
     UIModalTransitionStyleFlipHorizontal   翻转
     UIModalTransitionStyleCrossDissolve    渐变
     UIModalTransitionStylePartialCurl      翻半页
     */
    [loginMenu setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];

    [self presentViewController:loginMenu animated:YES completion:nil];

}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.infoSettings count];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *group = self.infoSettings[section];
    
    return [group[@"items"] count];

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        XNProfileDetailCell *cell = [XNProfileDetailCell tableViewCellWithTableView:tableView];
        cell.userInfo = self.userArray[0];
        return cell;
    }
    XNProfileCell *cell = [XNProfileCell tableViewCellWithTableView:tableView];
    // 获取数据
    NSDictionary *group = self.infoSettings[indexPath.section];
    NSDictionary *item = [group[@"items"] objectAtIndex:indexPath.row];
    
    cell.item = item;
    return cell;
}


#pragma mark - UITableViewDelegate

// 设置 row 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0 && indexPath.row == 0) {
        return 90.0f;
    }
    
    return [super tableView:tableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section - 1]];
}

// 设置头视图高度
//设置头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 15;
    }
    return 10;
}

//设置脚视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UIViewController *destVC = nil;
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        destVC = [[XNMineViewController alloc]init];
        [self.navigationController pushViewController:destVC animated:YES];
        return;
    }
    
    // 获取数据
    NSDictionary *group = self.infoSettings[indexPath.section];
    NSDictionary *item = [group[@"items"] objectAtIndex:indexPath.row];
    
    //获取当前单击的项的target_vc
    NSString *targetClassName = item[@"target_vc"];

    if (targetClassName) {
        //把字符串转换成类名
        Class TargetClass = NSClassFromString(targetClassName);
        destVC = [TargetClass new];
                
        destVC.navigationItem.title = item[@"title"];
        
        [self.navigationController pushViewController:destVC animated:YES];
    }
   
    //判断是否需要执行一段代码
    //1.判断是否有function_name这个key
    if ([item[@"function_name"] length] > 0) {
        //表示有对应的函数执行
        SEL func = NSSelectorFromString(item[@"function_name"]);

        //执行这个方法
        //调用func之前,有先判断当前控制器中是否实现了这个方法
        if ([self respondsToSelector:func]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Warc-performSelector-leaks"
            [self performSelector:func];
#pragma clang diagnostic pop       
        }
        
    }

}

// 清理缓存
- (void)clearMemory {

    NSLog(@"清理缓存");
}
// 分享 APP
- (void)shareAPP {

    [ShareManager shareToPlatform:self shareText:@"我正在使用聊城大学网络中心助手" shareImage:nil delegate:nil];

}
// 退出登录
- (void)Logout {
    NSLog(@"退出登录");

}

@end
