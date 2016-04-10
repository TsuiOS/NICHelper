//
//  XNRepairsController.m
//  NICHelper
//
//  Created by mac on 16/4/10.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNRepairsController.h"
#import "NetworkTools.h"

@interface XNRepairsController ()

@end

@implementation XNRepairsController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"在线报修";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_back_normal"] style: UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(composeClick)];
    [[NetworkTools sharedTools]composeMessageWithTitle:@"hhh" address:@"北京" phone:@"110" number:@"1234" studentName:@"小龙" reason:@"水晶头" finished:^(id result, NSError *error) {
       
        NSLog(@"%@",result);
    }];
}

- (void)back {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)composeClick {


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
