//
//  NoClassView.m
//  教学辅助平台-教师端
//
//  Created by 李梦珂 on 2018/2/7.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "NoClassView.h"
#import <Masonry.h>
@implementation NoClassView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"暂无数据";
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:20];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY).offset(-20);
            make.size.mas_equalTo(CGSizeMake(120,30));
        }];
    }
    return self;
}
@end
