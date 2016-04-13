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
#import "XNWeatherModel.h"
#import "XNProgressHUD.h"
#import <MJRefresh.h>
#import "NetworkTools.h"
#import "XNWeatherView.h"
#import "XNLocationController.h"
#import "UIView+Extension.h"
#import "XNBaseNavigationController.h"



#define  ViewDidScrollOffset   200.0
static NSString *ID = @"discover_cell";
NSString *const cityKey = @"cityKey";
NSString *const provinceKey = @"provinceKey";


@interface XNDiscoverController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (strong, nonatomic) UIView *parallaxHeaderView;
@property (strong, nonatomic) XNCoverView *coverView;
@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) MASConstraint *parallaxHeaderHeightConstraint;
@property (strong, nonatomic) MASConstraint *parallaxHeaderTopConstraint;
@property (nonatomic, strong) XNWeatherModel *CurrentWeatherData;
@property (nonatomic, strong) XNLocationController *locationVC;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *province;


@end

@implementation XNDiscoverController

- (void)viewWillAppear:(BOOL)animated {
    
    [self loadWeatherJSON];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [self configTableView];
    [self setupUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chooseCity) name:@"LoactionNotificationCenter" object:nil];
}

- (void)chooseCity {

    self.locationVC = [XNLocationController new];
    XNBaseNavigationController *nvc=[[XNBaseNavigationController alloc]initWithRootViewController:self.locationVC];
    __weak typeof(self) weakSelf = self;
    self.locationVC.completion = ^(NSString *city,NSString *province) {
        weakSelf.city = [city substringToIndex:[city length] - 1];
        weakSelf.province = province;
        //偏好设置
        [[NSUserDefaults standardUserDefaults] setObject:weakSelf.city forKey:cityKey];
        [[NSUserDefaults standardUserDefaults] setObject:weakSelf.province forKey:provinceKey];
        [[NSUserDefaults standardUserDefaults]synchronize];
    };
    
    [self presentViewController:nvc animated:YES completion:nil];

}

#pragma mark - Private methods
- (void)configTableView {
    
    _tableView = [[UITableView alloc]init];
    [self.view addSubview:_tableView];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEFAULT_WIDTH, kParallaxHeaderHeight)];
}


#pragma mark - 设置界面

- (void)setupUI {
 
    _parallaxHeaderView = [[UIView alloc]init];
    _parallaxHeaderView.clipsToBounds = YES;
    _parallaxHeaderView.backgroundColor = [UIColor redColor];
    UIImageView *imaView = [[UIImageView alloc]init];
    imaView.contentMode = UIViewContentModeScaleAspectFill;
    imaView.image = [UIImage imageNamed:@"niclcu"];
    
    
    _coverView = [[XNCoverView alloc]init];

    [_parallaxHeaderView addSubview:imaView];
    [_parallaxHeaderView addSubview:_coverView];
    
    
    [self.view addSubview:self.parallaxHeaderView];
    
    [_parallaxHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        _parallaxHeaderHeightConstraint = make.height.equalTo(@(kParallaxHeaderHeight));
    }];
    [_coverView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.edges.equalTo(self.parallaxHeaderView);
    }];
    [imaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.parallaxHeaderView);
    }];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-44);
    }];
    
    
    // Add KVO
    [_tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
}
// 利用KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {

    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGFloat offsetY = ((NSValue *)change[NSKeyValueChangeNewKey]).CGPointValue.y;
        
        if (offsetY < -64){
            _parallaxHeaderHeightConstraint.equalTo(@(kParallaxHeaderHeight - offsetY -64));
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


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    // 当控制器加载时不改变coverView的alpha
     // 往上滚动不改变coverView的alpha
    if (-scrollView.contentOffset.y <=  64) return;
    
    CGFloat alphaY = (ViewDidScrollOffset / -scrollView.contentOffset.y) - 1.5;
    
    NSLog(@"%f",alphaY);
    if (alphaY < 0) {
        alphaY = 0;
    }
    self.coverView.alpha = alphaY;
    
    // 当视图的contentOffset超过300时,刷新天气数据
    if (-scrollView.contentOffset.y > 300) {
        [self loadWeatherJSON];
    }
    
}
/**
 *  视图滚动完成后,恢复默认的coverView的alpha
 *
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [UIView animateWithDuration:0.5 animations:^{
       self.coverView.alpha = 1;
    }];
    
}
/**
 *  加载天气数据
 */
- (void)loadWeatherJSON {
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *city = [userDefaults objectForKey:cityKey];
    NSString *province = [userDefaults objectForKey:provinceKey];
    
    if (city == nil || province == nil) return;
    [XNProgressHUD show];

    [[NetworkTools sharedTools]loadWeatherWithCity:city province:province finished:^(NSDictionary *results, NSError *error) {
        
        [XNProgressHUD dismiss];
        if (error) {
            [XNProgressHUD showInfoWithStatus:@"世界上最遥远的距离就是没网"];
            return;
        }
        self.CurrentWeatherData = [[XNWeatherModel alloc]initWithDict:results];
        // 判断请求状态码
        if (![self.CurrentWeatherData.retCode isEqualToString:@"200"]) {
            [XNProgressHUD showInfoWithStatus:@"未查询到相应的天气"];
            return;
        }
        self.coverView.temperatureView.CurrentWeatherData = self.CurrentWeatherData;

    }];
    
}


@end
