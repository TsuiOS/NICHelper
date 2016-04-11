//
//  XNRepairsCell.h
//  NICHelper
//
//  Created by mac on 16/4/10.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XNRepairsCell;

@protocol XNRepairsCellDelegate <NSObject>

- (void)textViewCell:(XNRepairsCell *)cell didChangeText:(NSString *)text;

@end

@interface XNRepairsCell : UITableViewCell

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, weak) id<XNRepairsCellDelegate> delegate;

@end
