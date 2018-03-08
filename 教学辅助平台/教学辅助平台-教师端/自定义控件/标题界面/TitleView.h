//
//  TitleView.h
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/1/9.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
@interface TitleView : UIView

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *) title;
-(void)titleViewAppear;
-(void)titleViewDisappear;
@end
