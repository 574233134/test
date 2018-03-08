//
//  QuestionBankViewController.m
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/2/20.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import "QuestionBankViewController.h"
#import "ChoiceViewController.h"
static NSString *const questionBankViewControllerTalbeViewCellId = @"questionBankViewControllerTalbeViewCellId";

@interface QuestionBankViewController ()

@end

@implementation QuestionBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self loadNavigationControllerSetting];
    [self loadTableView];
    [self loadTransitionView];
    [self loadEmptyView];
    [self loadNoNetWorkingView];
    [self downLoadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadNavigationControllerSetting
{
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonAction)];
    self.navigationItem.leftBarButtonItem = cancelButton;
}
-(void)cancelButtonAction
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)downLoadData
{
    //关闭空题库界面
    [_titleView titleViewDisappear];
    //关闭无网络界面
    [_noNetWorkingView NoNetWorkingViewDisappear];
    //先开启动画
    [_transitionView transitionStart];
    UserManager *userManager = [UserManager sharedUserManager];
    [userManager getQuestionsWithType:@"choice" block:^(int result, NSArray *array) {
        //无论成功与否，先关闭动画
        [_transitionView transitionStop];
        if (result == 1) {
            //下载成功
            if (array.count == 0) {
                //题库为空
                [_titleView titleViewAppear];
            }
            else
            {
                _questionBankArray = array;
                [_questionBankTableView reloadData];
            }
        }
        else
        {
            //下载失败，开启无网络界面
            [_noNetWorkingView NoNetWorkingViewAppear];
        }
    }];
}
-(void)loadEmptyView
{
    _titleView = [[TitleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) title:@"题库暂空，快去添加吧"];
    [self.view addSubview:_titleView];
}
-(void)loadNoNetWorkingView
{
    _noNetWorkingView = [[NoNetWorkingView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    [self.view addSubview:_noNetWorkingView];
    _noNetWorkingView.delegate = self;
}
-(void)byClick
{
    //点击后重新下载
    [self downLoadData];
}
-(void)loadTransitionView
{
    _transitionView = [[Transition2View alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) backgroundCorlor:[UIColor whiteColor] title:@"加载中…"];
    [self.view addSubview:_transitionView];
}
-(void)loadTableView
{
    _questionBankTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStyleGrouped];
    [self.view addSubview:_questionBankTableView];
    _questionBankTableView.dataSource = self;
    _questionBankTableView.delegate = self;
    [_questionBankTableView registerClass:[QuestionBankTableViewCell class] forCellReuseIdentifier:questionBankViewControllerTalbeViewCellId];
    _questionBankTableView.bounces = NO;
    _questionBankTableView.tableHeaderView = [self createHeaderView];
}
-(UIView *)createHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(25, 10, self.view.frame.size.width-50, 20)];
    [headerView addSubview:label];
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:17];
    label.text = @"可拉取选择题";
    label.textAlignment = NSTextAlignmentCenter;
    return headerView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _questionBankArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuestionBankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:questionBankViewControllerTalbeViewCellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.questionTitleLabel.text = [_questionBankArray[indexPath.row] objectForKey:@"question"];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int select = [[_questionBankArray[indexPath.row] objectForKey:@"score"] intValue]-1;
    self.myChoiceViewController.scoreSegement.selectedSegmentIndex = select;
    self.myChoiceViewController.questionTextView.text = [_questionBankArray[indexPath.row] objectForKey:@"question"];
    self.myChoiceViewController.choiceATextField.text = [_questionBankArray[indexPath.row] objectForKey:@"choiceA"];
    self.myChoiceViewController.choiceBTextField.text = [_questionBankArray[indexPath.row] objectForKey:@"choiceB"];
    self.myChoiceViewController.choiceCTextField.text = [_questionBankArray[indexPath.row] objectForKey:@"choiceC"];
    self.myChoiceViewController.choiceDTextField.text = [_questionBankArray[indexPath.row] objectForKey:@"choiceD"];
    if ([[_questionBankArray[indexPath.row] objectForKey:@"answer"] isEqualToString:@"A"]) {
        [self.myChoiceViewController circleImageViewSingleTapAction];
    }
    else if ([[_questionBankArray[indexPath.row] objectForKey:@"answer"] isEqualToString:@"B"])
    {
        [self.myChoiceViewController circleImageViewSingleTapAction2];
    }
    else if ([[_questionBankArray[indexPath.row] objectForKey:@"answer"] isEqualToString:@"C"])
    {
        [self.myChoiceViewController circleImageViewSingleTapAction3];
    }
    else
    {
        [self.myChoiceViewController circleImageViewSingleTapAction4];
    }
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end
