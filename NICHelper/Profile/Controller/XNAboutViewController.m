//
//  XNAboutViewController.m
//  NICHelper
//
//  Created by mac on 16/4/10.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNAboutViewController.h"
#import "XNAboutHeader.h"

@interface XNAboutViewController ()

@end

@implementation XNAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    XNAboutHeader *headerView = [XNAboutHeader settingAboutHeader];
    self.tableView.tableHeaderView = headerView;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
