//
//  XNPopViewController.m
//  NICHelper
//
//  Created by mac on 16/3/19.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNPopViewController.h"
#import "XNColor.h"
#import "XNCollectController.h"
#import "XNBaseNavigationController.h"
#import "XNRepairsController.h"
#import "XNComposeController.h"

@interface XNPopViewController ()

@property (nonatomic, strong) NSArray *arrayList;

@end

@implementation XNPopViewController

- (NSArray *)arrayList {

    if (_arrayList == nil) {
        _arrayList = [NSArray arrayWithObjects:@"在线报修",@"发布文章",@"我的收藏", nil];
    }
    return _arrayList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.scrollEnabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.arrayList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString * const ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.arrayList[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        [self presentViewController:[XNRepairsController new]];

    } else if (indexPath.row == 1) {
        
        [self presentViewController:[XNComposeController new]];

    } else {
        [self presentViewController:[XNCollectController new]];
    }
}

- (void)presentViewController:(UIViewController *)viewController {

    XNBaseNavigationController *nvc = [[XNBaseNavigationController alloc]initWithRootViewController:viewController];
    [self presentViewController:nvc animated:YES completion:nil];
}


//重写preferredContentSize，让popover返回你期望的大小
- (CGSize)preferredContentSize {
    if (self.presentingViewController && self.tableView != nil) {
        CGSize tempSize = self.presentingViewController.view.bounds.size;
        tempSize.width = 120;
        CGSize size = [self.tableView sizeThatFits:tempSize];  //sizeThatFits返回的是最合适的尺寸，但不会改变控件的大小
        return size;
    }else {
        return [super preferredContentSize];
    }
}
- (void)setPreferredContentSize:(CGSize)preferredContentSize{
    super.preferredContentSize = preferredContentSize;
}
@end
