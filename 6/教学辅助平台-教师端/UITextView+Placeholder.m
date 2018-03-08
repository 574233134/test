//
//  UITextView+Placeholder.m
//  教学辅助平台-教师端
//
//  Created by 李梦珂 on 2018/2/10.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "UITextView+Placeholder.h"

@implementation UITextView (Placeholder)
-(void)setPlaceholder:(NSString *)placeholdStr placeholdColor:(UIColor *)placeholdColor
{
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = placeholdStr;
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = placeholdColor;
    placeHolderLabel.font = self.font;
    [placeHolderLabel sizeToFit];
    [self addSubview:placeHolderLabel];
    /*
     [self setValue:(nullable id) forKey:(nonnull NSString *)]
     ps: KVC键值编码，对UITextView的私有属性进行修改
     */
    // 通过runtime遍历可发现有私有属性_placeholderLabel
    [self setValue:placeHolderLabel forKey:@"_placeholderLabel"];
}
@end
