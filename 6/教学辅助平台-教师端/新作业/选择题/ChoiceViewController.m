//
//  ChoiceViewController.m
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/2/20.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import "ChoiceViewController.h"
#import "NewHomeworkViewController.h"
@interface ChoiceViewController ()

@end

@implementation ChoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self loadNavigationControllerSetting];
    [self loadScrollView];
    [self loadTransitionView];
    [self circleImageViewSingleTapAction];//默认选A
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadNavigationControllerSetting
{
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonAction)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    UIBarButtonItem *savelButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishButtonAction)];
    self.navigationItem.rightBarButtonItem = savelButton;
}
-(void)cancelButtonAction
{
    //放弃第一响应者
    [_questionTextView resignFirstResponder];
    [_choiceATextField resignFirstResponder];
    [_choiceBTextField resignFirstResponder];
    [_choiceCTextField resignFirstResponder];
    [_choiceDTextField resignFirstResponder];

    //弹出时由navigationController弹出，因此弹回 也由navigationController
    [self.navigationController dismissViewControllerAnimated:YES completion:^{}];
}
-(void)finishButtonAction
{
    //放弃第一响应者
    [_questionTextView resignFirstResponder];
    [_choiceATextField resignFirstResponder];
    [_choiceBTextField resignFirstResponder];
    [_choiceCTextField resignFirstResponder];
    [_choiceDTextField resignFirstResponder];
    if (_choiceATextField.text.length&&_choiceBTextField.text.length&&_choiceCTextField.text.length&&_choiceDTextField.text.length) {
        //只有所有空同时有值才能保存到题库并且进行完成提交
        //先开启动画
        [_transitionView transitionStart];
        UserManager *userManager = [UserManager sharedUserManager];
        [userManager saveToBankWithQuestion:_questionTextView.text choiceA:_choiceBTextField.text choiceB:_choiceBTextField.text choiceC:_choiceCTextField.text choiceD:_choiceDTextField.text andAnswer:_answer score:[NSNumber numberWithInt:(int)_scoreSegement.selectedSegmentIndex+1] block:^(int result, BmobObject *bmobObject) {
            //不管成功与否，先关闭动画
            [_transitionView transitionStop];
            if (result == 1) {
                //保存成功，将bmobObject对象添加到选择题数组，再将数组赋值给已添加选择题数组
                [_questionsArray addObject:bmobObject];
                self.myNewHomeworkViewController.choiceArray = _questionsArray;
                [userManager addQuestions:_questionsArray WithType:@"choice" toCourse:self.courseObject];
                [self.navigationController dismissViewControllerAnimated:YES completion:^{
                    [self.myNewHomeworkViewController refreshView];
                }];
            }
            else
            {
                //保存失败，提示检查网络后重试
                [self loadAlertControllerWithTitle:@"保存到题库失败" massage:@"请检查网络后重试"];
            }
        }];
    }
    else
    {
        //提示问题或者选项不能为空
        [self loadAlertControllerWithTitle:@"点击完成按钮前，本题中问题或者选项不能为空" massage:nil];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)loadTransitionView
{
    _transitionView = [[Transition2View alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) backgroundCorlor:[UIColor clearColor] title:@"保存题库中，请稍后…"];
    [self.view addSubview:_transitionView];
}

-(void)loadScrollView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_scrollView];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, (self.view.frame.size.height-64)*1.5);
    _scrollView.backgroundColor = [UIColor colorWithRed:239/256.0 green:239/256.0 blue:244/256.0 alpha:1];
    [self loadOtherViews];
}

-(void)loadOtherViews
{
    UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 25, 100, 20)];
    [_scrollView addSubview:scoreLabel];
    scoreLabel.text = @"选择分值：";
    [scoreLabel setFont:[UIFont systemFontOfSize:17]];
    scoreLabel.textColor = [UIColor darkGrayColor];

    NSArray *items = @[@"1分",@"2分",@"3分",@"4分",@"5分"];
    _scoreSegement = [[UISegmentedControl alloc]initWithItems:items];
    [_scrollView addSubview:_scoreSegement];
    _scoreSegement.frame = CGRectMake(125, 20, self.view.frame.size.width - 150, 30);
    _scoreSegement.selectedSegmentIndex = 2;
    _scoreSegement.tintColor = [UIColor darkGrayColor];
    
    UILabel *questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 60, 100, 20)];
    [_scrollView addSubview:questionLabel];
    questionLabel.text = @"问题：";
    [questionLabel setFont:[UIFont systemFontOfSize:17]];
    questionLabel.textColor = [UIColor darkGrayColor];

    _questionTextView = [[UITextView alloc] initWithFrame:CGRectMake(25, 90, self.view.frame.size.width-50, 60)];
    [_scrollView addSubview:_questionTextView];
    _questionTextView.backgroundColor = [UIColor whiteColor];
    _questionTextView.font = [UIFont systemFontOfSize:17];
    //_questionTextView.delegate = self;

    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 170, self.view.frame.size.width-50-40, 30)];
    [_scrollView addSubview:backgroundImageView];
    backgroundImageView.backgroundColor = [UIColor whiteColor];
    backgroundImageView.userInteractionEnabled = YES;
    _circleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"方形_未选中"] highlightedImage:[UIImage imageNamed:@"方形_选中"]];
    [_scrollView addSubview:_circleImageView];
    _circleImageView.userInteractionEnabled = YES;
    _circleImageView.frame = CGRectMake(self.view.frame.size.width-25-30, 170, 30, 30);
    UITapGestureRecognizer *circleImageViewSingleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(circleImageViewSingleTapAction)];
    [_circleImageView addGestureRecognizer:circleImageViewSingleTap];

    _choiceATextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 5, self.view.frame.size.width-50-40, 20)];
    [backgroundImageView addSubview:_choiceATextField];
    _choiceATextField.placeholder = @"选项A";
    [_choiceATextField setFont:[UIFont systemFontOfSize:17]];
    _choiceATextField.delegate = self;

    UIImageView *backgroundImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(25, 210, self.view.frame.size.width-50-40, 30)];
    [_scrollView addSubview:backgroundImageView2];
    backgroundImageView2.backgroundColor = [UIColor whiteColor];
    backgroundImageView2.userInteractionEnabled = YES;
    _circleImageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"方形_未选中"] highlightedImage:[UIImage imageNamed:@"方形_选中"]];
    [_scrollView addSubview:_circleImageView2];
    _circleImageView2.userInteractionEnabled = YES;
    _circleImageView2.frame = CGRectMake(self.view.frame.size.width-25-30, 210, 30, 30);
    UITapGestureRecognizer *circleImageViewSingleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(circleImageViewSingleTapAction2)];
    [_circleImageView2 addGestureRecognizer:circleImageViewSingleTap2];

    _choiceBTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 5, self.view.frame.size.width-50-40, 20)];
    [backgroundImageView2 addSubview:_choiceBTextField];
    _choiceBTextField.placeholder = @"选项B";
    [_choiceBTextField setFont:[UIFont systemFontOfSize:17]];
    _choiceBTextField.delegate = self;

    UIImageView *backgroundImageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(25, 250, self.view.frame.size.width-50-40, 30)];
    [_scrollView addSubview:backgroundImageView3];
    backgroundImageView3.backgroundColor = [UIColor whiteColor];
    backgroundImageView3.userInteractionEnabled = YES;
    _circleImageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"方形_未选中"] highlightedImage:[UIImage imageNamed:@"方形_选中"]];
    [_scrollView addSubview:_circleImageView3];
    _circleImageView3.userInteractionEnabled = YES;
    _circleImageView3.frame = CGRectMake(self.view.frame.size.width-25-30, 250, 30, 30);
    UITapGestureRecognizer *circleImageViewSingleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(circleImageViewSingleTapAction3)];
    [_circleImageView3 addGestureRecognizer:circleImageViewSingleTap3];

    _choiceCTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 5, self.view.frame.size.width-50-40, 20)];
    [backgroundImageView3 addSubview:_choiceCTextField];
    _choiceCTextField.placeholder = @"选项C";
    [_choiceCTextField setFont:[UIFont systemFontOfSize:17]];
    _choiceCTextField.delegate = self;

    UIImageView *backgroundImageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(25, 290, self.view.frame.size.width-50-40, 30)];
    [_scrollView addSubview:backgroundImageView4];
    backgroundImageView4.backgroundColor = [UIColor whiteColor];
    backgroundImageView4.userInteractionEnabled = YES;
    _circleImageView4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"方形_未选中"] highlightedImage:[UIImage imageNamed:@"方形_选中"]];
    [_scrollView addSubview:_circleImageView4];
    _circleImageView4.userInteractionEnabled = YES;
    _circleImageView4.frame = CGRectMake(self.view.frame.size.width-25-30, 290, 30, 30);
    UITapGestureRecognizer *circleImageViewSingleTap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(circleImageViewSingleTapAction4)];
    [_circleImageView4 addGestureRecognizer:circleImageViewSingleTap4];

    _choiceDTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 5, self.view.frame.size.width-50-40, 20)];
    [backgroundImageView4 addSubview:_choiceDTextField];
    _choiceDTextField.placeholder = @"选项D";
    [_choiceDTextField setFont:[UIFont systemFontOfSize:17]];
    _choiceDTextField.delegate = self;

    //题库按钮
    UIButton *questionBankButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.view addSubview:questionBankButton];
    questionBankButton.frame = CGRectMake(25, self.view.frame.size.height-64-60, 80, 30);
    questionBankButton.backgroundColor = [UIColor whiteColor];
    [questionBankButton addTarget:self action:@selector(questionBankButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [questionBankButton setTitle:@"题库" forState:UIControlStateNormal];
    [questionBankButton setTitle:@"题库" forState:UIControlStateHighlighted];
    questionBankButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [questionBankButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [questionBankButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    questionBankButton.layer.cornerRadius = 7;
    questionBankButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
    questionBankButton.layer.borderWidth = 1;

    //下一题按钮
    UIButton *nextquestionButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.view addSubview:nextquestionButton];
    nextquestionButton.frame = CGRectMake(self.view.frame.size.width-25-90, self.view.frame.size.height-64-60, 90, 30);
    nextquestionButton.backgroundColor = [UIColor whiteColor];
    [nextquestionButton addTarget:self action:@selector(nextquestionButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [nextquestionButton setTitle:@"下一题" forState:UIControlStateNormal];
    [nextquestionButton setTitle:@"下一题" forState:UIControlStateHighlighted];
    nextquestionButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [nextquestionButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [nextquestionButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    nextquestionButton.layer.cornerRadius = 7;
    nextquestionButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
    nextquestionButton.layer.borderWidth = 1;

    //处理单击，来放弃第一响应者
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction)];
    [self.view addGestureRecognizer:singleTap];

}
-(void)circleImageViewSingleTapAction
{
    _circleImageView.highlighted = YES;
    _circleImageView2.highlighted = NO;
    _circleImageView3.highlighted = NO;
    _circleImageView4.highlighted = NO;
    _answer = @"A";
}
-(void)circleImageViewSingleTapAction2
{
    _circleImageView.highlighted = NO;
    _circleImageView2.highlighted = YES;
    _circleImageView3.highlighted = NO;
    _circleImageView4.highlighted = NO;
    _answer = @"B";
}
-(void)circleImageViewSingleTapAction3
{
    _circleImageView.highlighted = NO;
    _circleImageView2.highlighted = NO;
    _circleImageView3.highlighted = YES;
    _circleImageView4.highlighted = NO;
    _answer = @"C";
}
-(void)circleImageViewSingleTapAction4
{
    _circleImageView.highlighted = NO;
    _circleImageView2.highlighted = NO;
    _circleImageView3.highlighted = NO;
    _circleImageView4.highlighted = YES;
    _answer = @"D";
}
-(void)singleTapAction
{
    //放弃第一响应者
    [_questionTextView resignFirstResponder];
    [_choiceATextField resignFirstResponder];
    [_choiceBTextField resignFirstResponder];
    [_choiceCTextField resignFirstResponder];
    [_choiceDTextField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //放弃第一响应者
    [_questionTextView resignFirstResponder];
    [_choiceATextField resignFirstResponder];
    [_choiceBTextField resignFirstResponder];
    [_choiceCTextField resignFirstResponder];
    [_choiceDTextField resignFirstResponder];
    return YES;
}

-(void)questionBankButtonAction
{
    //放弃第一响应者
    [_questionTextView resignFirstResponder];
    [_choiceATextField resignFirstResponder];
    [_choiceBTextField resignFirstResponder];
    [_choiceCTextField resignFirstResponder];
    [_choiceDTextField resignFirstResponder];
    
    QuestionBankViewController *questionBankViewController = [[QuestionBankViewController alloc] init];
    questionBankViewController.title = @"从题库拉取";
    questionBankViewController.myChoiceViewController = self;
    UINavigationController *questionBankNavigationController = [[UINavigationController alloc] initWithRootViewController:questionBankViewController];
    questionBankNavigationController.navigationBar.barTintColor = [UIColor colorWithRed:243/256.0 green:92/256.0 blue:90/256.0 alpha:1];
    questionBankNavigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]};
    questionBankNavigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self presentViewController:questionBankNavigationController animated:YES completion:^{}];

}
-(void)nextquestionButtonAction
{
    //放弃第一响应者
    [_questionTextView resignFirstResponder];
    [_choiceATextField resignFirstResponder];
    [_choiceBTextField resignFirstResponder];
    [_choiceCTextField resignFirstResponder];
    [_choiceDTextField resignFirstResponder];
    if (_choiceATextField.text.length&&_choiceBTextField.text.length&&_choiceCTextField.text.length&&_choiceDTextField.text.length) {
        //只有所有空同时有值才能保存到题库并下一题
        //先开启动画
        [_transitionView transitionStart];
        UserManager *userManager = [UserManager sharedUserManager];
        [userManager saveToBankWithQuestion:_questionTextView.text choiceA:_choiceBTextField.text choiceB:_choiceBTextField.text choiceC:_choiceCTextField.text choiceD:_choiceDTextField.text andAnswer:_answer score:[NSNumber numberWithInt:(int)_scoreSegement.selectedSegmentIndex+1] block:^(int result, BmobObject *bmobObject) {
            //不管成功与否，先关闭动画
            [_transitionView transitionStop];
            if (result == 1) {
                //保存成功，将bmobObject对象添加到选择题数组
                [_questionsArray addObject:bmobObject];
                //再push新的一题
                ChoiceViewController *choiceViewController = [[ChoiceViewController alloc] init];
                choiceViewController.title = [NSString stringWithFormat:@"选择题%ld",_questionsArray.count+1];
                choiceViewController.questionsArray = _questionsArray;
                choiceViewController.courseObject = self.courseObject;
                choiceViewController.myNewHomeworkViewController = self.myNewHomeworkViewController;
                [self.navigationController pushViewController:choiceViewController animated:YES];
            }
            else
            {
                //保存失败，提示检查网络后重试
                [self loadAlertControllerWithTitle:@"保存到题库失败" massage:@"请检查网络后重试"];
            }
        }];
    }
    else
    {
        //提示问题或者选项不能为空
        [self loadAlertControllerWithTitle:@"设置下一题目前，本题中问题或者选项不能为空" massage:nil];
    }
}
-(void)loadAlertControllerWithTitle:(NSString *) title massage:(NSString *) massage
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:massage preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alertController animated:YES completion:^{}];
}

@end
