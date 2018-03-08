//
//  ChoiceViewController.h
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/2/20.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserManager.h"
#import "QuestionBankViewController.h"
@class NewHomeworkViewController;

@interface ChoiceViewController : UIViewController<UITextFieldDelegate>


{
    Transition2View *_transitionView;
    UIImageView *_circleImageView;
    UIImageView *_circleImageView2;
    UIImageView *_circleImageView3;
    UIImageView *_circleImageView4;

    UIScrollView *_scrollView;
    UISegmentedControl *_scoreSegement;//分值
    UITextView *_questionTextView;//问题
    UITextField *_choiceATextField;//选项A
    UITextField *_choiceBTextField;//选项B
    UITextField *_choiceCTextField;//选项C
    UITextField *_choiceDTextField;//选项D
    NSString *_answer;//答案
}
@property (nonatomic,retain) NSMutableArray *questionsArray;
@property (nonatomic,retain) BmobObject *courseObject;

@property (nonatomic,retain) NewHomeworkViewController *myNewHomeworkViewController;

@property (nonatomic,retain) UISegmentedControl *scoreSegement;//分值
@property (nonatomic,retain) UITextView *questionTextView;//问题
@property (nonatomic,retain) UITextField *choiceATextField;//选项A
@property (nonatomic,retain) UITextField *choiceBTextField;//选项B
@property (nonatomic,retain) UITextField *choiceCTextField;//选项C
@property (nonatomic,retain) UITextField *choiceDTextField;//选项D
@property (nonatomic,retain) NSString *answer;//答案
-(void)circleImageViewSingleTapAction;
-(void)circleImageViewSingleTapAction2;
-(void)circleImageViewSingleTapAction3;
-(void)circleImageViewSingleTapAction4;

@end
