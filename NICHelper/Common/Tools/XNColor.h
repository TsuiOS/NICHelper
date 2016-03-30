//
//  XNColor.h
//  NICHelper
//
//  Created by mac on 16/3/7.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#ifndef XNColor_h
#define XNColor_h
#define XNColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define     DEFAULT_NAVBAR_COLOR             XNColor(20.0, 20.0, 20.0, 0.9)
#define     DEFAULT_SEARCHBAR_COLOR          XNColor(239.0, 239.0, 244.0, 1.0)
#define     DEFAULT_GREEN_COLOR              XNColor(2.0, 187.0, 0.0, 1.0f)
#define     DEFAULT_BACKGROUND_COLOR         XNColor(224, 231, 234, 1)
// 16进制转换RGB
#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// 常用标准颜色
#define kColorBlack kUIColorFromRGB(0x2A2A2A)
#define kColorBlackDeep kUIColorFromRGB(0x000000)
#define kColorBlackLight kUIColorFromRGB(0x686868)
#define kColorGray kUIColorFromRGB(0xC9C9C9)
#define kColorRed  kUIColorFromRGB(0xFF3939)
#define kColorOrange kUIColorFromRGB(0xFF5F00)
#define kColorGreen kUIColorFromRGB(0x00AA83)
#define kColorWhite kUIColorFromRGB(0xFFFFFF)

// 常用宽高
#define DEFAULT_WIDTH               [UIScreen mainScreen].bounds.size.width
#define DEFAULT_HEIGTH              [UIScreen mainScreen].bounds.size.height
#define kParallaxHeaderHeight      200


// 通知
#define kQQLoginNotification @"QQLoginNotification"

#endif /* XNColor_h */
