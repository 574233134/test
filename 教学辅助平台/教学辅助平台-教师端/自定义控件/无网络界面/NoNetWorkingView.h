//
//  NoNetWorkingView.h
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/1/6.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>

@protocol NoNetWorkingViewDelegate<NSObject>
-(void)byClick;
@end

@interface NoNetWorkingView : UIView

@property (nonatomic,retain) id<NoNetWorkingViewDelegate> delegate;
-(void)NoNetWorkingViewAppear;
-(void)NoNetWorkingViewDisappear;
@end
