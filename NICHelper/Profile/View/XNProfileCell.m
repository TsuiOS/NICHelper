//
//  XNProfileCell.m
//  NICHelper
//
//  Created by mac on 16/3/18.
//  Copyright © 2016年 Hsu. All rights reserved.
//

#import "XNProfileCell.h"

@implementation XNProfileCell

+ (instancetype)tableViewCellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"message_cell";
    
    XNProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XNProfileCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

- (void)setItem:(NSDictionary *)item {
    _item = item;
    
    if (item[@"icon"]) { //照片是否为空
         self.imageView.image = [UIImage imageNamed:item[@"icon"]];
    }
    self.textLabel.text = item[@"title"];
    
    //4.设置accessory
    if (item[@"accessory"] && [item[@"accessory"] length] > 0) {
        //根据配置,来生成一个类 把字符串转换成类
        Class AccessoryClass = NSClassFromString(item[@"accessory"]);
        
        //根据类创建一个对象
        id accessory_obj = [[AccessoryClass alloc]init];
        UIImageView *imageView = (UIImageView *)accessory_obj;
        imageView.image = [UIImage imageNamed:item[@"accessory_img"]];
        
        //设置图片的大小
        [imageView sizeToFit];
        
        self.accessoryView = accessory_obj;
    }
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
