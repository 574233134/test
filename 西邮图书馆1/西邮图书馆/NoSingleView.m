//
//  NoSingleView.m
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/2/16.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import "NoSingleView.h"
#import <Masonry.h>
@implementation NoSingleView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(void)initSubviews
{
    UIImageView *nosingle = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"信号"]];
    [self addSubview:nosingle];
    
    [nosingle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(-80);
        make.size.mas_equalTo(CGSizeMake(100, 70));
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
