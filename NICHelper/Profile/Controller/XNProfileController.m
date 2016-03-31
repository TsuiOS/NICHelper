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

@interface XNProfileController ()

@property (nonatomic, strong) NSArray *infoSettings;
@property (nonatomic, strong) NSDictionary *userDict;

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
    
    self.userDict = notification.userInfo;
    [self.tableView reloadData];
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
        cell.userDict = self.userDict;
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
    NSLog(@"%zd",indexPath.row);

    UIViewController *destVC = nil;
    
    // 获取数据
    NSDictionary *group = self.infoSettings[indexPath.section];
    NSDictionary *item = [group[@"items"] objectAtIndex:indexPath.row];
    
    //获取当前单击的项的target_vc
    NSString *targetClassName = item[@"target_vc"];

    if (targetClassName) {
        //把字符串转换成类名
        Class TargetClass = NSClassFromString(targetClassName);
        destVC = [TargetClass new];
    }
    destVC.navigationController.title = item[@"title"];
    
    [self.navigationController pushViewController:destVC animated:YES];

}

@end
