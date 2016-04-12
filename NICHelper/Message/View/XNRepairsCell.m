//
//  XNRepairsCell.m
//  NICHelper
//
//  Created by mac on 16/4/10.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNRepairsCell.h"
#import <Masonry.h>

@interface XNRepairsCell ()<UITextViewDelegate>


@end

@implementation XNRepairsCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //取消 cell 点击显示灰色的效果
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UITextView *textView = [[UITextView alloc]init];
        self.textView = textView;
        textView.allowsEditingTextAttributes = YES;
        textView.delegate = self;
        textView.scrollEnabled = NO;
        textView.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:textView];
        
    }
    
    return self;
}

- (void)layoutSubviews {
    
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 5, 0,5);

    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(padding);
    }];
}

#pragma mark - UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    if ([textView.text isEqualToString:@"\n"]) {
        [textView scrollRangeToVisible:textView.selectedRange];

    }
    
}
- (void)textViewDidEndEditing:(UITextView *)textView {

}


-(void)textViewDidChangeSelection:(UITextView *)textView {
    
//    NSLog(@"%@",textView.selectedRange);
//    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
//        CGRect r = [textView caretRectForPosition:textView.selectedTextRange.end];
//        CGFloat caretY =  MAX(r.origin.y - textView.frame.size.height + r.size.height + 8, 0);
//        if (textView.contentOffset.y < caretY && r.origin.y != INFINITY) {
//            textView.contentOffset = CGPointMake(0, caretY);
//        }
//    }
    
}

- (void)textViewDidChange:(UITextView *)textView {


    
    if ([self.delegate respondsToSelector:@selector(textViewCell:didChangeText:)]) {
        [self.delegate textViewCell:self didChangeText:textView.text];
    }
    
    CGRect bounds = textView.bounds;
    
    //计算 textView 的高度
    CGSize maxSize = CGSizeMake(bounds.size.width, CGFLOAT_MAX);
    CGSize newSize = [textView sizeThatFits:maxSize];
    
    bounds.size = newSize;
    
    UITableView *tableView = [self tableView];
    // 让 tableView 重新计算高度
    [tableView beginUpdates];
    [tableView endUpdates];
    
    
}

- (UITableView *)tableView
{
    UIView *tableView = self.superview;
    
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    
    return (UITableView *)tableView;
}




@end
