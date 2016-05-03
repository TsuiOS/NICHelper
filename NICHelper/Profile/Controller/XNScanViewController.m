//
//  XNScanViewController.m
//  NICHelper
//
//  Created by mac on 16/3/18.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNScanViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface XNScanViewController ()

/** 输入设备 */
@property (nonatomic, strong) AVCaptureDeviceInput *input;
/** 输出设备 */
@property (nonatomic, strong) AVCaptureMetadataOutput *output;
/** 会话 */
@property (nonatomic, strong) AVCaptureSession *session;
/** 特殊的 layer */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;


@end

@implementation XNScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self scan];
}

- (void)scan {
    
    //输入设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    //输出设备
    self.output = [AVCaptureMetadataOutput new];
    
    //创建会话
    self.session = [AVCaptureSession new];
    //会话扫描展示
    [self.session setSessionPreset:AVCaptureSessionPreset640x480];
    
    // layer
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.session];
    
    // 指定 layer 的大小
    self.previewLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:self.previewLayer];

}


@end
