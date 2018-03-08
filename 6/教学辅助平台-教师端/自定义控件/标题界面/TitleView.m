//
//  TitleView.m
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/1/9.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import "TitleView.h"

@implementation TitleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *) title
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.backgroundColor = [UIColor whiteColor];

        UILabel *busyLabel = [[UILabel alloc] init];
        [self addSubview:busyLabel];
        [busyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
            make.top.equalTo(self.mas_centerY).offset(-30);
            make.left.equalTo(self.mas_left).offset(30);
            make.right.equalTo(self.mas_right).offset(-30);
            
        }];
        busyLabel.text = title;
        busyLabel.textColor = [UIColor grayColor];
        busyLabel.textAlignment = NSTextAlignmentCenter;
        busyLabel.font = [UIFont systemFontOfSize:20];
    }
    return self;
}
-(void)titleViewAppear
{
    self.hidden = NO;
}
-(void)titleViewDisappear
{
    self.hidden = YES;
}

@end
