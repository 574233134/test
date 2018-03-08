//
//  NewHomeworkViewController.h
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/2/20.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserManager.h"
#import "NewHomeworkTableViewCell.h"
#import "TitleView.h"
#import "ChoiceViewController.h"
@interface NewHomeworkViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

{
    TitleView *_titleView;
    UITableView *_newHomeworkTableView;
}
@property (nonatomic,retain) BmobObject *courseObject;
@property (nonatomic,retain) NSMutableArray *choiceArray;
@property (nonatomic,retain) NSMutableArray *judgeArray;;
@property (nonatomic,retain) NSMutableArray *fillArray;
@property (nonatomic,retain) NSMutableArray *QandAArray;
-(void)refreshView;
@end
