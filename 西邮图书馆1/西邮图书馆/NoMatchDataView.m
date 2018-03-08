//
//  NoMatchDataView.m
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/2/16.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import "NoMatchDataView.h"
#import <Masonry.h>
@implementation NoMatchDataView

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
    UILabel *nomatchdataLabel = [[UILabel alloc]init];
    nomatchdataLabel.text = @"未匹配到数据";
    nomatchdataLabel.textAlignment = NSTextAlignmentCenter;
    nomatchdataLabel.textColor = [UIColor colorWithWhite:0.7 alpha:1];
    nomatchdataLabel.font = [UIFont systemFontOfSize:20];
    [self addSubview:nomatchdataLabel];
    
    [nomatchdataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_centerY).offset(-80);
        make.size.mas_equalTo(CGSizeMake(180, 40));
    }];
}

@end
