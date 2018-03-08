//
//  ChoiceQuestionViewController.m
//  教学辅助平台-教师端
//
//  Created by 李梦珂 on 2018/2/20.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "ChoiceQuestionViewController.h"
#import "UserManager.h"
@interface ChoiceQuestionViewController ()

@end

@implementation ChoiceQuestionViewController
{
    NSArray *dataarray;
    UITableView *choicetableview;
    FailedLoding *failedview;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadSubview];
     [self loadData];
    
}
-(instancetype)init
{
    self = [super init];
    if (self)
    {
        self.courseobject=[[BmobObject alloc]init];
        dataarray = [NSArray array];
    }
    return self;
}
-(void)loadSubview
{
    self.view.backgroundColor = [UIColor whiteColor];
    choicetableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)
                                                  style:UITableViewStyleGrouped];
    choicetableview.delegate = self;
    choicetableview.dataSource = self;
    [self.view addSubview:choicetableview];
    
    _tansitionview = [[TransitionView alloc]initWithFrame:choicetableview.frame];
    [self.view addSubview:_tansitionview];
    
    _noclassview = [[NoClassView alloc]initWithFrame:choicetableview.frame];
    _noclassview.hidden = YES;
    [self.view addSubview:_noclassview];
    
    failedview = [[FailedLoding alloc]initWithFrame:choicetableview.frame];
    failedview.hidden = YES;
    failedview.delagate = self;
    [choicetableview addSubview:failedview];
}
-(void)loadData
{
    _noclassview.hidden = YES;
    failedview.hidden = YES;
    [_tansitionview transitionStart];
    UserManager *manger = [UserManager sharedUserManager];
    [manger getQuestionsOfCourse:self.courseobject WithType:@"choice" block:^(int result, NSArray *array) {
        if (result)
        {
            dataarray = array;
            if (array.count == 0)
            {
                [choicetableview reloadData];
                [_tansitionview transitionEnd];
                _noclassview.hidden = NO;
            }
            else
            {
                
                _noclassview.hidden = YES;
                [choicetableview reloadData];
                [_tansitionview transitionEnd];
            }
        }
        else
        {
            [_tansitionview transitionEnd];
            failedview.hidden = NO;
        }
    }];
}
#pragma tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0000001;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // 设置section背景颜色
    view.tintColor = [UIColor groupTableViewBackgroundColor];
    
    // 设置section字体颜色
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setFont:[UIFont systemFontOfSize:16]];
}
#pragma tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.textColor = [UIColor blackColor];
    if(indexPath.row == 0)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"A.  %@",[dataarray[indexPath.section
                                                                       ] objectForKey:@"choiceA"]];
    }
    else if(indexPath.row == 1)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"B.  %@",[dataarray[indexPath.section
                                                                             ] objectForKey:@"choiceB"]];
    }
    else if(indexPath.row == 2)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"C.  %@",[dataarray[indexPath.section
                                                                             ] objectForKey:@"choiceC"]];
    }
    else if(indexPath.row == 3)
    {
        
        cell.textLabel.text = [NSString stringWithFormat:@"D.  %@",[dataarray[indexPath.section
                                                                             ] objectForKey:@"choiceD"]];
    }
    else if(indexPath.row == 4)
    {
        cell.textLabel.textColor = [UIColor redColor];
        cell.textLabel.textAlignment = NSTextAlignmentRight;
        cell.textLabel.text = [NSString stringWithFormat:@"正确答案： %@",[dataarray[indexPath.section
                                                                             ] objectForKey:@"answer"]];
    }
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataarray.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title;
    title = [NSString stringWithFormat:@"%lu. (%@分) %@ ",section+1,[dataarray[section
                                                                            ] objectForKey:@"score"],[dataarray[section
                                                                                                               ] objectForKey:@"question"]];
    return title;
    
}
#pragma failedloadingview delegate
//失败后点击刷新按钮重新加载数据
-(void)checknetwork
{
    [self loadData];
}
@end
