//
//  UILabel+AutoFitWidth.h
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/1/19.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (AutoFitWidth)
+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font;
@end
