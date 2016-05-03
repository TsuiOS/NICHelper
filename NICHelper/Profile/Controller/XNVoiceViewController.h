//
//  XNVoiceViewController.h
//  NICHelper
//
//  Created by mac on 16/5/2.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iflyMSC/iflyMSC.h"

@interface XNVoiceViewController : UIViewController<IFlyRecognizerViewDelegate>

@property (nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;//带界面的识别对象

@end
