//
//  XNComposeController.m
//  NICHelper
//
//  Created by mac on 16/3/4.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNComposeController.h"
#import "NetworkTools.h"

@interface XNComposeController ()

@end

@implementation XNComposeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[NetworkTools sharedTools]composeTipsWithTitle:@"呵呵呵" content:@"&content=未未未未未未未未未未未未未未未未未" from:@"NIC" finished:^(id result, NSError *error) {
        NSLog(@"%@",result);
    }];
    self.title = @"Tips";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_back_normal"] style: UIBarButtonItemStylePlain target:self action:@selector(back)];
}

- (void)back {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
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
