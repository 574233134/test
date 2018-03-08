//
//  TransitionView.h
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/1/3.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
@interface Transition2View : UIView

-(instancetype)initWithFrame:(CGRect)frame backgroundCorlor:(UIColor *)corlor title:(NSString *)title;
-(void)transitionStart;
-(void)transitionStop;
@end
