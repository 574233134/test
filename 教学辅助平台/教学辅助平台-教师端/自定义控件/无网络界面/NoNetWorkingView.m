//
//  NoNetWorkingView.m
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/1/6.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import "NoNetWorkingView.h"

@implementation NoNetWorkingView

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
    if (self) {
        self.hidden = YES;
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *busyImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"网络无法连接"]];
        [self addSubview:busyImageView];
        [busyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.and.height.equalTo(@150);
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY).offset(-75);
        }];
        
        UILabel *busyLabel = [[UILabel alloc] init];
        [self addSubview:busyLabel];
        [busyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
            make.top.equalTo(self.mas_centerY).offset(20);
            make.left.equalTo(self.mas_left).offset(30);
            make.right.equalTo(self.mas_right).offset(-30);
            
        }];
        busyLabel.text = @"无网络，点击重试";
        busyLabel.textColor = [UIColor grayColor];
        busyLabel.textAlignment = NSTextAlignmentCenter;
        busyLabel.font = [UIFont systemFontOfSize:20];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        //添加手势识别器
        [self addGestureRecognizer:singleTap];
    }
    return self;
}
-(void)tap
{
    [_delegate byClick];
}
-(void)NoNetWorkingViewAppear
{
    self.hidden = NO;
}
-(void)NoNetWorkingViewDisappear
{
    self.hidden = YES;
}
@end
