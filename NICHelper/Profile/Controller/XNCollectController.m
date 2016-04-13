//
//  XNCollectController.m
//  NICHelper
//
//  Created by mac on 16/3/18.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNCollectController.h"
#import "XNMessageTool.h"
#import "XNColor.h"
#import <Masonry.h>
#import "XNProfileController.h"
#import "XNCollectCell.h"


@interface XNCollectController ()

/** 存放收藏的任务 */
@property (nonatomic, strong) NSMutableArray *collectMessage;
/** 没有收藏时显示的提醒图片 */
@property(nonatomic, strong) UIImageView *noDataView;


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

- (UIImageView *)noDataView
{
    if (_noDataView == nil) {
        _noDataView = [[UIImageView alloc] init];
        _noDataView.image = [UIImage imageNamed:@"icon_collects_empty"];
        [self.view addSubview:_noDataView];
        // 约束
        [_noDataView sizeToFit];
        [_noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.centerY.equalTo(self.view.mas_centerY).offset(-64);
        }];;
    }
    return _noDataView;
}


#pragma mark - 初始化

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    
    // 设置背景颜色
    self.view.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    // 注册 cell
    [self.tableView registerClass:[XNCollectCell class] forCellReuseIdentifier:ID];
    //设置 cell 的高度
    self.tableView.rowHeight = 180;
    // 移除收据
    [self.collectMessage removeAllObjects];
    // 添加数据
    [self.collectMessage addObjectsFromArray:[XNMessageTool collectedMessage]];
    // 刷新数据
    [self.tableView reloadData];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // modal 的时候执行下面的代码
    if ([self.navigationController viewControllers].count == 1) {
        self.title = @"收藏";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_back_normal"] style: UIBarButtonItemStylePlain target:self action:@selector(back)];
    }

    
}
- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.noDataView.hidden = (self.collectMessage.count > 0);
    if(self.collectMessage.count > 0) {
        //取消分割线
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    } else {
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self.collectMessage.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    XNCollectCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
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
