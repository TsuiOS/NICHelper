//
//  XNDiscoverController.m
//  NICHelper
//
//  Created by mac on 16/3/7.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNDiscoverController.h"
#import "ParallaxHeaderView.h"
#import "UMSocial.h"
#import "XNColor.h"
#import <Masonry.h>
static CGFloat ParallaxHeaderHeight = 140;

@interface XNDiscoverController ()<UIScrollViewDelegate>

@end

@implementation XNDiscoverController


- (void)viewDidLoad {
    [super viewDidLoad];
    ParallaxHeaderView *headerView = [ParallaxHeaderView parallaxHeaderViewWithImage:[UIImage imageNamed:@"sun"] forSize:CGSizeMake(DEFAULT_WIDTH, ParallaxHeaderHeight)];
    [self.tableView setTableHeaderView:headerView];

}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"discover_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = @(indexPath.row).stringValue;

    return cell;
}

#pragma mark - UISCrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    if (scrollView == self.tableView) {
        [(ParallaxHeaderView *)self.tableView.tableHeaderView layoutHeaderViewForScrollViewOffset:scrollView.contentOffset];
    }

}

#pragma mark - UITableViewDelegate
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    
//    static NSString *ID = @"headerView";
//    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
//    
//    if (!headerView) {
//        headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:ID];
//    }
//    headerView.textLabel.text = @"天气预报";
//    return headerView;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//
//    return 44;
//}



@end
