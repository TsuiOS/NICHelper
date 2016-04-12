//
//  XNDetailCell.h
//  NICHelper
//
//  Created by mac on 16/4/12.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XNMessage;
@class XNDetailCell;

@protocol XNDetailCellDelegate <NSObject>

- (void)detailCell:(XNDetailCell *)cell switchExpandedStateWithIndexPath:(NSIndexPath *)index;

@end


@interface XNDetailCell : UITableViewCell


@property (nonatomic, weak) id<XNDetailCellDelegate> delegate;

- (void)setDetailMessage:(XNMessage *)detailMessage indePath:(NSIndexPath *)indexPath;


@end
