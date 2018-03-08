//
//  NewHomeworkViewController.m
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/2/20.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import "NewHomeworkViewController.h"
static NSString *const newHomeworkViewControllerTalbeViewCellId = @"newHomeworkViewControllerTalbeViewCellId";

@interface NewHomeworkViewController ()

@end

@implementation NewHomeworkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self loadNavigationControllerSetting];
    [self loadTableView];
    [self loadEmptyWorkView];
    [self refreshView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadNavigationControllerSetting
{
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonAction)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    UIBarButtonItem *savelButton = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addButtonAction)];
    self.navigationItem.rightBarButtonItem = savelButton;
}
-(void)refreshView
{
    [_newHomeworkTableView reloadData];
    if (_choiceArray.count > 0 || _judgeArray.count > 0 || _fillArray.count > 0 || _QandAArray.count > 0)//当有任何一个数据时，关闭未添加题型界面，否则显示
    {
        [_titleView titleViewDisappear];
    }
    else
    {
        [_titleView titleViewAppear];
    }
}
-(void)loadEmptyWorkView
{
    _titleView = [[TitleView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) title:@"未添加题型"];
    [self.view addSubview:_titleView];
}

-(void)cancelButtonAction
{
    //弹出时由navigationController弹出，因此弹回 也由navigationController
    [self.navigationController dismissViewControllerAnimated:YES completion:^{}];
}
-(void)addButtonAction
{
    //注意，注释部分留着方便以后扩展支持的题型
    NSString *string = nil;
    if (_choiceArray.count == 0)// || _judgeArray.count == 0 || _fillArray.count == 0 || _QandAArray.count == 0)
    {
        string = @"题型";
    }
    else
    {
        string = @"无可用操作";
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:string message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    if (_choiceArray.count == 0) {
        [alertController addAction:[UIAlertAction actionWithTitle:@"选择题" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            ChoiceViewController *choiceViewController = [[ChoiceViewController alloc] init];
            choiceViewController.questionsArray = [NSMutableArray array];
            choiceViewController.courseObject = self.courseObject;
            choiceViewController.myNewHomeworkViewController = self;
            choiceViewController.title = [NSString stringWithFormat:@"选择题%ld",choiceViewController.questionsArray.count+1];
            UINavigationController *choiceNavigationController = [[UINavigationController alloc] initWithRootViewController:choiceViewController];
            choiceNavigationController.navigationBar.barTintColor = [UIColor colorWithRed:243/256.0 green:92/256.0 blue:90/256.0 alpha:1];
            choiceNavigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]};
            choiceNavigationController.navigationBar.tintColor = [UIColor whiteColor];
            [self.navigationController presentViewController:choiceNavigationController animated:YES completion:^{}];
        }]];
    }
//    if (_judgeArray.count == 0) {
//        [alertController addAction:[UIAlertAction actionWithTitle:@"判断题" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        }]];
//    }
//    if (_fillArray.count == 0) {
//        [alertController addAction:[UIAlertAction actionWithTitle:@"填空题" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        }]];
//    }
//    if (_QandAArray.count == 0) {
//        [alertController addAction:[UIAlertAction actionWithTitle:@"问答题" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        }]];
//    }
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction         * _Nonnull action) {
    }]];
    [self presentViewController:alertController animated:YES completion:^{}];
}

-(void)loadTableView
{
    _newHomeworkTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStyleGrouped];
    [self.view addSubview:_newHomeworkTableView];
    _newHomeworkTableView.dataSource = self;
    _newHomeworkTableView.delegate = self;
    _newHomeworkTableView.backgroundColor = [UIColor whiteColor];
    [_newHomeworkTableView registerClass:[NewHomeworkTableViewCell class] forCellReuseIdentifier:newHomeworkViewControllerTalbeViewCellId];
    _newHomeworkTableView.bounces = NO;
    _newHomeworkTableView.tableHeaderView = [self createHeaderView];
    _newHomeworkTableView.tableFooterView = [self createFooterView];
}
-(UIView *)createHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(25, 10, self.view.frame.size.width-50, 20)];
    [headerView addSubview:label];
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:17];
    label.text = @"已添加题型";
    label.textAlignment = NSTextAlignmentCenter;
    return headerView;
}
-(UIView *)createFooterView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    footerView.backgroundColor = [UIColor whiteColor];
    //提交按钮
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [footerView addSubview:submitButton];
    submitButton.frame = CGRectMake(25, 0, self.view.frame.size.width-50, 50);
    submitButton.backgroundColor = [UIColor colorWithRed:243/256.0 green:92/256.0 blue:90/256.0 alpha:1];
    [submitButton addTarget:self action:@selector(submitButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton setTitle:@"提交" forState:UIControlStateHighlighted];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    submitButton.layer.cornerRadius = 7;

    return footerView;
}
-(void)submitButtonAction
{
    [self loadSubmitAlertController];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int numberOfrows = 0;//计算返回的row数量
    if (_choiceArray.count > 0) {
        numberOfrows++;
    }
    if (_judgeArray.count > 0) {
        numberOfrows++;
    }
    if (_fillArray.count > 0) {
        numberOfrows++;
    }
    if (_QandAArray.count > 0) {
        numberOfrows++;
    }
    return numberOfrows;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewHomeworkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:newHomeworkViewControllerTalbeViewCellId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSMutableArray *array = [NSMutableArray array];//生成已添加题型的数组
    if (_choiceArray.count > 0) {
        [array addObject:@"选择题"];
    }
    if (_judgeArray.count > 0) {
        [array addObject:@"判断题"];
    }
    if (_fillArray.count > 0) {
        [array addObject:@"填空题"];
    }
    if (_QandAArray.count > 0) {
        [array addObject:@"问答题"];
    }
    cell.typeLabel.text = array[indexPath.row];
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

-(void)loadSubmitAlertController
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请为本次作业命名" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {}];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UserManager *userManager = [UserManager sharedUserManager];
        //先删除上次作业
        [userManager deleteTaskOfCourseWithObjectId:[self.courseObject objectId] types:@[@"choice"] block:^(int result) {
            if (result == 1) {
                //删除成功，开始提交本次作业
                [userManager submitTastWithTitle:alertController.textFields[0].text course:self.courseObject block:^(int result) {
                    if (result == 1) {
                        //提交成功，关闭模态视图并且刷新tableView
                        [self.navigationController dismissViewControllerAnimated:YES completion:^{
                            //此处进行刷新
                        }];
                    }
                    else
                    {
                        [self loadFailAlertControllerWithTitle:@"提交失败！" massage:@"请检查网络后重试"];
                    }
                }];
            }
            else
            {
                //删除失败
                [self loadFailAlertControllerWithTitle:@"提交失败！" massage:@"注，已删除上次作业，但新的作业未提交成功，请检查网络后重试"];
            }
        }];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction         * _Nonnull action) {}]];
    [self presentViewController:alertController animated:YES completion:^{}];
}
//请求失败后调用
-(void)loadFailAlertControllerWithTitle:(NSString *) title massage:(NSString *) massage
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:massage preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alertController animated:YES completion:^{}];
}
@end
