//
//  CourseInfoViewController.m
//  教学辅助平台-教师端
//
//  Created by 李梦珂 on 2018/2/20.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "CourseInfoViewController.h"
#import "CurrentWorkViewController.h"
@interface CourseInfoViewController ()

@end

@implementation CourseInfoViewController
{
    UITableView *coursetableview;
    NSArray *dataArray;
}
-(instancetype)init
{
    self = [super init];
    if (self)
    {
        self.courseobject = [[BmobObject alloc]init];
        dataArray = [[NSArray alloc]initWithObjects:@"当前作业",@"分数统计",@"学生管理", nil];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = [self.courseobject objectForKey:@"coursename"];
    NSLog(@"%@",[self.courseobject objectForKey:@"coursename"]);
}

-(void)loadView
{
    [super loadView];
    [self loadSubview];
}
-(void)loadSubview
{
    self.view.backgroundColor = [UIColor whiteColor];
    coursetableview = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [self.view addSubview:coursetableview];
    coursetableview.delegate = self;
    coursetableview.dataSource = self;
    coursetableview.bounces = NO;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}
#pragma tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;//设置cell右侧箭头
    return cell;
}
#pragma tableview delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        CurrentWorkViewController *cwviewcontroller = [[CurrentWorkViewController alloc]init];
        cwviewcontroller.courseobject = self.courseobject;
        [self.navigationController pushViewController:cwviewcontroller animated:YES];
    }
    else if (indexPath.row == 1)
    {
        
    }
    else if(indexPath.row == 2)
    {
        
    }
}
@end
