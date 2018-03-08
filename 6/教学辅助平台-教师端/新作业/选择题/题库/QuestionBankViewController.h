//
//  QuestionBankViewController.h
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/2/20.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionBankTableViewCell.h"
#import "NoNetWorkingView.h"
#import "Transition2View.h"
#import "UserManager.h"
#import "TitleView.h"
@class ChoiceViewController;

@interface QuestionBankViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NoNetWorkingViewDelegate>

{
    NoNetWorkingView *_noNetWorkingView;
    Transition2View *_transitionView;
    TitleView *_titleView;

    UITableView *_questionBankTableView;
    NSArray *_questionBankArray;
}
@property (nonatomic,retain) ChoiceViewController *myChoiceViewController;

@end
