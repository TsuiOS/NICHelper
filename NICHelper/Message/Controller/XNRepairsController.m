//
//  XNRepairsController.m
//  NICHelper
//
//  Created by mac on 16/4/10.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNRepairsController.h"
#import "NetworkTools.h"
#import "UITextField+Extension.h"
#import "XNProgressHUD.h"
#import "UIView+Extension.h"
#import "XNRepairsCell.h"


@interface XNRepairsController ()<XNRepairsCellDelegate>


@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) NSString *addressString;
@property (nonatomic, strong) NSString *phoneString;
@property (nonatomic, strong) NSString *numberString;
@property (nonatomic, strong) NSString *studentNameString;
@property (nonatomic, strong) NSString *reasonString;

@property (nonatomic, strong) NSArray *repairsArray;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, assign) NSInteger oldRow;


@end

static NSString *ID = @"repairs_cell";

@implementation XNRepairsController

#pragma mark - 创建tableView的时候默认是分组样式的
- (instancetype)init {
    
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    
    return [super initWithStyle:UITableViewStyleGrouped];
}

#pragma mark - 懒加载

- (NSArray *)repairsArray {
    if (_repairsArray == nil) {
        _repairsArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"Repairs" ofType:@"plist"]];
    }
    return _repairsArray;
}

- (NSArray *)data {

    if (_data == nil) {
        _data = [[NSArray alloc]initWithObjects:@"",@"",@"",@"",@"",@"", nil];
    }
    return _data;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"在线报修";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style: UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(composeClick)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    // 注册 cell
    [self.tableView registerClass:[XNRepairsCell class] forCellReuseIdentifier:ID];
    // 取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 预估行高
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.repairsArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *groups = self.repairsArray[section];
    return [groups count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XNRepairsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.delegate = self;
    
    // 注意点:必须根据 section 来获取数据
    cell.textView.text = self.data[indexPath.section];
    return cell;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    NSDictionary *groups = self.repairsArray[section];
    
    return groups[@"title"];
}


#pragma mark - XNRepairsCellDelegate

- (void)textViewCell:(XNRepairsCell *)cell didChangeText:(NSString *)text {
    
    self.navigationItem.rightBarButtonItem.enabled = YES;

    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    // mutableCopy创建一个可变的副本 深Copy(内容 copy)
    NSMutableArray *data = [self.data mutableCopy];
    data[indexPath.section] = text;
    
    //copy 创建一个不可变得副本 (内容 copy)
    self.data = [data copy];
}

#pragma mark - 私有方法
- (void)back {
    
    UIAlertView *alerView = [[UIAlertView alloc]initWithTitle:nil message:@"确定要放弃此次编辑" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alerView.tag = 0;
    [alerView show];
    
}

#pragma mark - UIAlertViewDelegate
//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self resignFirstResponder];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

- (void)composeClick {
    
    
    for (NSString *text in self.data) {
        if (text.length == 0) {
            [XNProgressHUD showInfoWithStatus:@"请把信息填写完整"];
            
            return;
        }
    }
    self.studentNameString = self.data[0];
    self.phoneString = self.data[1];
    self.numberString = self.data[2];
    self.addressString = self.data[3];
    self.titleString = self.data[4];
    self.reasonString = self.data[5];
    
    [[NetworkTools sharedTools]composeMessageWithTitle:self.titleString
                                               address:self.addressString
                                                 phone:self.phoneString
                                                number:self.numberString
                                           studentName:self.studentNameString
                                                reason:self.reasonString
                                              finished:^(id result, NSError *error) {
          
    }];
    
}



@end
