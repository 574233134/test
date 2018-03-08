//
//  ClassViewController.h
//  教学辅助平台-教师端
//
//  Created by 李梦珂 on 2017/12/30.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransitionView.h"
#import "FailedLoding.h"
#import "NoClassView.h"
@interface ClassViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,FailedLodingDelagate>
@property TransitionView *tansitionview;
@property NoClassView *noclassview;
@end
