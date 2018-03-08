//
//  TransitionView.m
//  教学辅助平台-教师端
//
//  Created by 李梦珂 on 2018/2/7.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "FailedLoding.h"
#import <Masonry.h>
@implementation FailedLoding
{
    UIImageView *failImage;
    UILabel *failTextlable;
    UIButton *reFresh;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.backgroundColor = [UIColor whiteColor];
        self.opaque = NO;
        reFresh = [UIButton buttonWithType:UIButtonTypeSystem];
        reFresh.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
        reFresh.layer.cornerRadius = 5;
        reFresh.layer.borderWidth = 0;
        [reFresh setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [reFresh setTitle:@"刷新" forState:UIControlStateNormal];
        [reFresh addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:reFresh];
        [reFresh mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_centerX).offset(-30);
            make.top.equalTo(self.mas_centerY).offset(-20);
           make.size.mas_equalTo(CGSizeMake(60 , 30));
        }];
        
        failTextlable =[[UILabel alloc]init];
        failTextlable.text = @"网络好像不给力";
        failTextlable.textAlignment=NSTextAlignmentCenter;
        failTextlable.font = [UIFont systemFontOfSize:13];
        failTextlable.textColor = [UIColor redColor];
        [self addSubview:failTextlable];
        [failTextlable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(reFresh.mas_top).offset(-5);
            make.left.equalTo(self.mas_centerX).offset(-50);
            make.size.mas_equalTo(CGSizeMake(100, 30));
        }];

        failImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"网络好像不给力"]];
        [self addSubview:failImage];
        [failImage mas_makeConstraints:^(MASConstraintMaker *make) {
            //make.left.equalTo(self).offset(0);
            make.left.equalTo(self.mas_centerX).offset(-40);
            make.bottom.equalTo(failTextlable.mas_top).offset(-5);
            make.size.mas_equalTo(CGSizeMake(80, 86));
            
        }];

    }
    return self;
}
-(void)refresh
{
    self.hidden = YES;
    [self.delagate checknetwork];
}
@end
