//
//  XNMineViewController.m
//  NICHelper
//
//  Created by mac on 16/4/10.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNMineViewController.h"
#import "XNBlurEffectMenu.h"
#import "NetworkTools.h"
static NSString * ID = @"mine_cell";

NSString *kLoginMineCenter = @"kLoginMineCenter";

@interface XNMineViewController ()

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSArray *userInfo;



@end

@implementation XNMineViewController

#pragma mark - 创建tableView的时候默认是分组样式的
- (instancetype)init {
    
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (NSArray *)array {

    if (_array == nil) {
        _array = [NSArray arrayWithObjects:@"用户名",
                  @"手机号码",@"昵称",@"QQ",@"宿舍",@"班级",@"地址", nil];
    }
    return _array;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userinfo"];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
 
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID = @"mine_cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.textLabel.text = self.array[indexPath.row];
    cell.detailTextLabel.text = self.userInfo[indexPath.row];
    
    return cell;
}





@end
