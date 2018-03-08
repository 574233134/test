//
//  TransitionView.m
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/1/3.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import "Transition2View.h"

@implementation Transition2View

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame backgroundCorlor:(UIColor *)corlor title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.backgroundColor = corlor;
        UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] init];
        [self addSubview:activityIndicatorView];
        [activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
        }];
        activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [activityIndicatorView startAnimating];
        
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.width.equalTo(self.mas_width);
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY).offset(20);
        }];
        label.text = title;
        label.textAlignment = NSTextAlignmentCenter;
        [label setFont:[UIFont systemFontOfSize:13]];
        label.textColor = [UIColor grayColor];
    }
    return self;
}
-(void)transitionStart
{
    self.hidden = NO;
}
-(void)transitionStop
{
    self.hidden = YES;
}
@end
