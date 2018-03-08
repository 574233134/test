//
//  UILabel+AutoFitWidth.m
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/1/19.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import "UILabel+AutoFitWidth.h"

@implementation UILabel (AutoFitWidth)
//根据文字获取label宽度
+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}
//根据文字获取label高度
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}@end
