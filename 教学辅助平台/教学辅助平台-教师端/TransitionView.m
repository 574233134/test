//
//  TransitionView.m
//  教学辅助平台-教师端
//
//  Created by 李梦珂 on 2018/2/7.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "TransitionView.h"
#import <Masonry.h>
@implementation TransitionView
{
    UIActivityIndicatorView* activity;
    UILabel *loading;
}
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
        self.backgroundColor = [UIColor whiteColor];
        self.opaque = NO;
        activity = [[UIActivityIndicatorView alloc]init];
        [activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        activity.center=CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2-30);
        
        [self addSubview:activity];
        
        loading = [[UILabel alloc]init];
        loading.textAlignment = NSTextAlignmentCenter;
        loading.text = @"加载中...";
        loading.font = [UIFont systemFontOfSize:13];
        [self addSubview:loading];
        [loading mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(60, 30));
            
        }];
        
        self.hidden = YES;
    }
    return self;
}
-(void)transitionStart
{
    [activity startAnimating];
    self.hidden = NO;
}
-(void)transitionEnd
{
    [activity endEditing:YES];
    self.hidden = YES;
}
@end
