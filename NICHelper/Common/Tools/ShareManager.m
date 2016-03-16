//
//  ShareManager.m
//  NICHelper
//
//  Created by mac on 16/3/13.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "ShareManager.h"
#import <UMSocial.h>
#define XNAPPKEY @"56dfe2a467e58e8423002a33"



@implementation ShareManager

/**
    
 形参名            含义
 controller         分享列表页面所在的UIViewController对象
 appKey             友盟appKey，如果你在其他地方用UMSocialData设置了appKey，这里也可以传nil
 shareText          分享编辑页面的内嵌文字
 shareImage         分享编辑页面的内嵌图片，用户可以在编辑页面中删除。如果你不需要分享图片，可以传入nil
 shareToSnsNames	定义列表出现的微博平台字符串构成的数组，字符变量名为UMShareToSina、UMShareToTencent、UMShareToWechatSession、UMShareToWechatTimeline、UMShareToQzone、UMShareToQQ、UMShareToRenren、UMShareToDouban、UMShareToEmail、UMShareToSms、UMShareToFacebook、UMShareToTwitter，分别代表新浪微博、腾讯微博、微信好友、微信朋友圈、QQ空间、手机QQ、人人网、豆瓣、电子邮箱、短信、Facebook、Twitter
 delegate           实现分享状态回调方法的对象，回调方法的实现可以参见分享详细说明的回调方法部分。如果你不需要回调的话，可以设为nil
 */

/**
*  分享
*
*  @param controller 分享列表页面所在的UIViewController对象
*  @param shareText  分享编辑页面的内嵌文字
*  @param shareImage 分享编辑页面的内嵌图片,如果你不需要分享图片，可以传入nil
*  @param delegate   实现分享状态回调方法的对象,如果你不需要回调的话，可以设为nil
*/
+ (void)shareToPlatform:(UIViewController *)controller shareText:(NSString *)shareText shareImage:(UIImage *)shareImage delegate:(id)delegate {
    // 指定分享平台
    NSArray *sharedPlatform = [NSArray arrayWithObjects:UMShareToSina,UMShareToQzone,UMShareToSms,UMShareToQQ,UMShareToWechatSession,UMShareToWechatTimeline,nil];
    
    [UMSocialSnsService presentSnsIconSheetView:controller
                                         appKey:XNAPPKEY
                                      shareText:shareText
                                     shareImage:shareImage
                                shareToSnsNames:sharedPlatform
                                       delegate:delegate];

}


@end
