//
//  NorecordView.m
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/2/6.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import "NorecordView.h"
#import <Masonry.h>
@implementation NorecordView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubview];
    }
    return self;
}
-(void)initSubview
{
    self.backgroundColor = [UIColor whiteColor];
    UILabel *norecoreLabel = [[UILabel alloc]init];
    norecoreLabel.text = @"暂无记录";
    norecoreLabel.textAlignment = NSTextAlignmentCenter;
    norecoreLabel.textColor = [UIColor colorWithWhite:0.7 alpha:1];
    norecoreLabel.font = [UIFont systemFontOfSize:20];
    [self addSubview:norecoreLabel];
    
    [norecoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_centerY).offset(-20);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
