//
//  ChoiceQuestionViewController.h
//  教学辅助平台-教师端
//
//  Created by 李梦珂 on 2018/2/20.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BmobSDK/Bmob.h>
#import "TransitionView.h"
#import "FailedLoding.h"
#import "NoClassView.h"
@interface ChoiceQuestionViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,FailedLodingDelagate>
@property(retain)BmobObject *courseobject;
@property TransitionView *tansitionview;
@property NoClassView *noclassview;
@end
