//
//  ClassViewController.m
//  教学辅助平台-教师端
//
//  Created by 李梦珂 on 2017/12/30.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import "ClassViewController.h"
#import "NewClassViewController.h"
#import "CourseInfoViewController.h"
#import "UserManager.h"
@interface ClassViewController ()

@end

@implementation ClassViewController
{
    UITableView *classTableview;
    NSMutableArray *allCourseName;
    NSArray *dataArray;
    FailedLoding *failedview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}

-(void)loadView
{
    [super loadView];
    [self loadSubviews];
  
}
-(void)loadSubviews
{
    allCourseName = [NSMutableArray array];
    dataArray = [NSArray array];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"加号"] style:UIBarButtonItemStylePlain target:self action:@selector(edit)];
    
    
    
    
    classTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-108) style:UITableViewStylePlain];
    classTableview.separatorStyle=NO;
    classTableview.bounces = NO;;
    classTableview.dataSource = self;
    classTableview.delegate = self;
    [self.view addSubview:classTableview];
    
   
    _tansitionview = [[TransitionView alloc]initWithFrame:classTableview.frame];
    [self.view addSubview:_tansitionview];
    
    _noclassview = [[NoClassView alloc]initWithFrame:classTableview.frame];
    _noclassview.hidden = YES;
    [self.view addSubview:_noclassview];
    
    failedview = [[FailedLoding alloc]initWithFrame:classTableview.frame];
    failedview.hidden = YES;
    failedview.delagate = self;
    [classTableview addSubview:failedview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}
// 加载数据  获取用户创建的所有课堂
-(void)loadData
{
    _noclassview.hidden = YES;
    failedview.hidden = YES;
    [_tansitionview transitionStart];
    UserManager *manger = [UserManager sharedUserManager];
    [manger updateUserInfoFromBackgroundWithblock:^(int result) {
        if (result)
        {
            [manger getCoursesWithTeacher:manger.userInfo block:^(int result, NSArray *array) {
                if (result)
                {
                    dataArray = array;
                    if (array.count == 0)
                    {
                        [classTableview reloadData];
                        [_tansitionview transitionEnd];
                        _noclassview.hidden = NO;
                    }
                    else
                    {
                        
                        _noclassview.hidden = YES;
                        for (NSInteger i=0; i<array.count; i++)
                        {
                            allCourseName[i] = [array[i] objectForKey:@"coursename"];
                        }
                        [classTableview reloadData];
                        [_tansitionview transitionEnd];
                    }
                    
                }
            }];
        }
        else
        {
            [_tansitionview transitionEnd];
            failedview.hidden = NO;
        }

    }];
    
    

}
-(void)edit
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择以下操作" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *addCourse = [UIAlertAction actionWithTitle:@"新建课堂" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self addcourse];
    }];
    UIAlertAction *deleteCourse =[UIAlertAction actionWithTitle:@"删除课堂" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self deleteCourse];
    }];
    UIAlertAction *cancel =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:addCourse];
    [alertController addAction:deleteCourse];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
    

}
// 弹出删除课堂alert
-(void)deleteCourse
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"删除课程" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    //增加取消按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    //增加确定按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //获取第1个输入框；
        UITextField *courseTextField = alertController.textFields.firstObject;
        if(![allCourseName containsObject:courseTextField.text])
        {
            [self alertWithTitle:@"删除课程失败！" massage:@"您并未创建该课程"];
        }
        else
        {
            
            NSInteger index = [allCourseName indexOfObject:courseTextField.text];
            [allCourseName removeObjectAtIndex:index];
            NSString *courseId = [dataArray[index] objectForKey:@"objectId"];
            [self deleteClass:courseId];
        }
        
    }]];
    //定义第一个输入框；
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder = @"请输入课程名";
        
    }];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
// 删除指定课堂
-(void)deleteClass:(NSString *)courseId
{
    UserManager *manger = [UserManager sharedUserManager];
    [manger removeCourseWithObjectId:courseId block:^(int result) {
        if (result)
        {
            [self loadData];
        }
        else
        {
            [_tansitionview transitionEnd];
            [self alertWithTitle:@"删除课程失败" massage:@"请检查网络后重试"];
        }
    }];
}
// 弹出添加课堂alert
-(void)addcourse
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"新建课程" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    //增加取消按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    //增加确定按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //获取第1个输入框；
        UITextField *userNameTextField = alertController.textFields.firstObject;
        if([allCourseName containsObject:userNameTextField.text])
        {
            [self alertWithTitle:@"新建课堂失败！" massage:@"您已创建过该课堂。"];
        }
        else
        {
            [self addClass:userNameTextField.text];
        }
        
    }]];
    //定义第一个输入框；

    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder = @"请输入课程名";
        
    }];
    
    [self presentViewController:alertController animated:true completion:nil];
}
//添加课堂信息
-(void)addClass:(NSString *)className
{
    UserManager *manger = [UserManager sharedUserManager];
    [manger updateUserInfoFromBackgroundWithblock:^(int result) {
        if (result)
        {
            [manger newCourseWithName:className teacher:manger.userInfo block:^(int result) {
                if (result) {
                    [self loadData];
                }
                else
                {
                    [_tansitionview transitionEnd];
                    [self alertWithTitle:@"创建失败！" massage:@"请检查网络后重试！"];
                }
            }];

        }
    }];
}

-(void)alertWithTitle:(NSString *)title massage:(NSString *)massage
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:title message:massage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVc addAction:okAction];
    [self presentViewController:alertVc animated:YES completion:nil];
}
#pragma tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return allCourseName.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *indentify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentify];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentify];
    }
    switch (indexPath.row%4)
    {
        case 0:
             cell.contentView.backgroundColor = [UIColor colorWithRed:202/256.0 green:235/256.0 blue:216/256.0 alpha:1];
            
            break;
        case 1:
            cell.contentView.backgroundColor = [UIColor colorWithRed:240/256.0 green:255/256.0 blue:255/256.0 alpha:1];
            break;
        case 2:
            cell.contentView.backgroundColor = [UIColor colorWithRed:225/256.0 green:235/256.0 blue:205/256.0 alpha:1];
            break;
        case 3:
           
            cell.contentView.backgroundColor = [UIColor colorWithRed:245/256.0 green:245/256.0 blue:245/256.0 alpha:1];
            break;
            
        default:
            break;
    }
    cell.textLabel.text = allCourseName[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    
    return cell;
}
#pragma tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CourseInfoViewController *couresevc = [[CourseInfoViewController alloc]init];
    couresevc.courseobject = dataArray[indexPath.row];
    couresevc.title = allCourseName[indexPath.row];
    couresevc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:couresevc animated:YES];
}
#pragma failedloadingview delegate
//失败后点击刷新按钮重新加载数据
-(void)checknetwork
{
    [self loadData];
}
@end
