//
//  TransitionView.m
//  教学辅助平台-教师端
//
//  Created by 李梦珂 on 2018/2/7.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FailedLodingDelagate<NSObject>
-(void)checknetwork;
@end
@interface FailedLoding : UIView
@property(weak)id<FailedLodingDelagate>delagate;
@end
