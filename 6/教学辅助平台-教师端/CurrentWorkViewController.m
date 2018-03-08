//
//  CurrentWorkViewController.m
//  教学辅助平台-教师端
//
//  Created by 李梦珂 on 2018/2/20.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "CurrentWorkViewController.h"
#import "CourseInfoViewController.h"
#import "ChoiceQuestionViewController.h"
#import <Masonry.h>
#import "NewHomeworkViewController.h"
@interface CurrentWorkViewController ()

@end

@implementation CurrentWorkViewController
{
    UITableView *cwtableview;
    NSArray *dataarray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
}
-(instancetype)init
{
    self = [super init];
    if (self)
    {
        self.courseobject = [[BmobObject alloc]init];
        dataarray = [[NSArray alloc]initWithObjects:@"选择题",@"填空题",@"问答题", nil];
    }
    return self;
}
-(void)loadView
{
    [super loadView];
    [self loadSubview];
}
-(void)loadSubview
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"当前作业";
    cwtableview = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    cwtableview.delegate = self;
    cwtableview.dataSource = self;
    cwtableview.bounces = NO;
    [self.view addSubview:cwtableview];
    
    UIView *headerview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    UILabel *titlelabel = [[UILabel alloc]init];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.text = [self.courseobject objectForKey:@"title"];
    [headerview addSubview:titlelabel];
    [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerview.mas_centerX);
        make.centerY.equalTo(headerview.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(200, 40));
    }];
    cwtableview.tableHeaderView = headerview;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"新作业" style:UIBarButtonItemStylePlain target:self action:@selector(newwork)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"向左箭头"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];


    
}
-(void)back
{
    
    CourseInfoViewController *courseinfovc = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    NSLog(@"title:%@",courseinfovc.title);
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)newwork
{
    NewHomeworkViewController *newHomeworkViewController = [[NewHomeworkViewController alloc] init];
    newHomeworkViewController.title = @"新作业";
    newHomeworkViewController.courseObject = self.courseobject;
    UINavigationController *newHomeworkNavigationController = [[UINavigationController alloc] initWithRootViewController:newHomeworkViewController];
    newHomeworkNavigationController.navigationBar.barTintColor = [UIColor colorWithRed:243/256.0 green:92/256.0 blue:90/256.0 alpha:1];
    newHomeworkNavigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]};
    newHomeworkNavigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self presentViewController:newHomeworkNavigationController animated:YES completion:^{}];
}
#pragma tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataarray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = dataarray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;//设置cell右侧箭头
    return cell;
}
#pragma tableview delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        ChoiceQuestionViewController *choicevc = [[ChoiceQuestionViewController alloc]init];
        choicevc.title = @"选择题";
        choicevc.courseobject = self.courseobject;
        [self.navigationController pushViewController:choicevc animated:YES];
    }
    else if (indexPath.row == 1)
    {
        
    }
    else if(indexPath.row == 2)
    {
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0000001;
}
@end
