//
//  XNDiscoverController.m
//  NICHelper
//
//  Created by mac on 16/3/7.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNDiscoverController.h"
#import "UMSocial.h"
#import <Masonry.h>
static CGFloat ParallaxHeaderHeight = 235;



@interface XNDiscoverController ()

@property (strong, nonatomic) UIImageView *parallaxHeaderView;

@end

@implementation XNDiscoverController

#pragma mark - 懒加载
- (UIImageView *)parallaxHeaderView {
    if (_parallaxHeaderView == nil) {
        _parallaxHeaderView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"parallax_header_back"]];
        _parallaxHeaderView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _parallaxHeaderView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

//直接在scrollViewDidScroll:刷新
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0) {
        [_parallaxHeaderView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(ParallaxHeaderHeight - scrollView.contentOffset.y));
        }];
    } else {
        [_parallaxHeaderView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(ParallaxHeaderHeight));
        }];
    }
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

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    static NSString *ID = @"headerView";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    
    if (!headerView) {
        headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:ID];
    }
    headerView.textLabel.text = @"天气预报";
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 44;
}

@end
