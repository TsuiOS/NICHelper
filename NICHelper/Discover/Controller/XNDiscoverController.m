//
//  XNDiscoverController.m
//  NICHelper
//
//  Created by mac on 16/3/7.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNDiscoverController.h"
#import "UMSocial.h"
#import "XNColor.h"
#import <Masonry.h>
#import "XNCoverView.h"
#define  ViewDidScrollOffset   394.0
static NSString *ID = @"discover_cell";


@interface XNDiscoverController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (strong, nonatomic) UIImageView *parallaxHeaderView;
@property (strong, nonatomic) XNCoverView *coverView;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) MASConstraint *parallaxHeaderHeightConstraint;

@end

@implementation XNDiscoverController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTableView];
    [self setupUI];
}

#pragma mark - 生命周期的方法
/**
 *  当视图出现时, tableView 向下滚动ParallaxHeaderHeight的高度
 */
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_tableView setContentOffset:CGPointMake(0, -kParallaxHeaderHeight)];
}
#pragma mark - Private methods
- (void)configTableView {
    
    _tableView = [[UITableView alloc]init];
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.contentInset = UIEdgeInsetsMake(kParallaxHeaderHeight, 0, 0, 0);
}


#pragma mark - 设置界面

- (void)setupUI {
    
    // 添加控件
    // 把Parallax Header放在UITableView的下面
    _parallaxHeaderView = [UIImageView new];
    _parallaxHeaderView.contentMode = UIViewContentModeScaleAspectFill;
    _parallaxHeaderView.image = [UIImage imageNamed:@"niclcu"];
    [self.view insertSubview:_parallaxHeaderView belowSubview:_tableView];
    

    _coverView = [XNCoverView new];
    [self.view insertSubview:_coverView belowSubview:_tableView];
    
    
    // 自动布局
    [_coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_parallaxHeaderView);
    }];
    [_parallaxHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        _parallaxHeaderHeightConstraint = make.height.equalTo(@(kParallaxHeaderHeight));
    }];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-44);
    }];
    
    
    // Add KVO
    [_tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
}
// 利用KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint contentOffset = ((NSValue *)change[NSKeyValueChangeNewKey]).CGPointValue;
        if (contentOffset.y < -kParallaxHeaderHeight) {
            _parallaxHeaderHeightConstraint.equalTo(@(-contentOffset.y));

        }
    }
}

// remove KVO
- (void)dealloc {
    [_tableView removeObserver:self forKeyPath:@"contentOffset"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = @(indexPath.row).stringValue;
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (-scrollView.contentOffset.y == kParallaxHeaderHeight) {
        return;
    }
    CGFloat alphaY = (ViewDidScrollOffset / -scrollView.contentOffset.y) - 1.5;
    
    if (alphaY < 0) {
        alphaY = 0;
    }
    NSLog(@"%f",alphaY);
       self.coverView.alpha = alphaY;

}



@end
