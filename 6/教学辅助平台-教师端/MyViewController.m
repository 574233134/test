//
//  MyViewController.m
//  教学辅助平台-教师端
//
//  Created by 李梦珂 on 2017/12/30.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import "MyViewController.h"
#import "LoginViewController.h"
#import "FAQViewController.h"
#import "AboutUsViewController.h"
#import "ChangePasswordViewController.h"
#import "ChangeUserInfoViewController.h"
#import "FeedBackViewController.h"
#import "UserManager.h"
#import <Masonry.h>
@interface MyViewController ()

@end

@implementation MyViewController
{
    UITableView *myTableView;
    UIImageView *imageview;
    UIImage *userImage;
}
-(instancetype)init
{
    self = [super init];
    if (self) {
        self.dataArray = [[NSMutableArray alloc]initWithObjects:@"常见问题",@"关于我们",@"修改密码",@"意见反馈",@"退出当前账户", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
       // Do any additional setup after loading the view.
}
-(void)loadView
{
    [super loadView];
    _userSchool = @"学校";
    _teacherID = @"教工号";
    UserManager *manger = [UserManager sharedUserManager];
    _name = [manger.userInfo objectForKey:@"username"];
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    myTableView.bounces = NO;
    myTableView.dataSource = self;
    myTableView.delegate = self;
    imageview= [[UIImageView alloc]init];
    imageview.image = [UIImage imageNamed:@"头像"];
    
    
    [self.view addSubview:myTableView];
   }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadSection0:(UITableViewCell *)cell
{
    [cell.contentView addSubview:imageview];
    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.mas_left).offset(10);
        make.top.equalTo(cell.mas_top).offset(5);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    
    UILabel *name = [[UILabel alloc]init];
    [cell.contentView addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageview.mas_right).offset(20);
        make.top.equalTo(imageview.mas_top);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    name.font = [UIFont systemFontOfSize:20];
    name.text = _name;

    
    
    UILabel *userschool = [[UILabel alloc]init];
    [cell.contentView addSubview:userschool];
    [userschool mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageview.mas_right).offset(20);
        make.top.equalTo(name.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    userschool.font = [UIFont systemFontOfSize:14];
    userschool.text = _userSchool;
    
    
    UILabel *teacherID = [[UILabel alloc]init];
    [cell.contentView addSubview:teacherID];
    [teacherID mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userschool.mas_right).offset(10);
        make.top.equalTo(userschool.mas_top);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    teacherID.font = [UIFont systemFontOfSize:14];
    teacherID.text = _teacherID;
}

#pragma tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else
    {
        return _dataArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    UITableViewCell *cell = [myTableView dequeueReusableCellWithIdentifier:identify];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    NSArray *view = [cell.contentView subviews];
    for (int i=0; i<view.count; i++) {
        [view[i] removeFromSuperview];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0)
    {
        [self loadSection0:cell];
    }
    else if (indexPath.section == 1)
    {
        cell.textLabel.text = _dataArray[indexPath.row];
        //设置cell右侧的箭头
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}
#pragma tableview delagete
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 80;
    }
    else
        return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        [self changeUserInfo];
    }
    if(indexPath.section == 1)
    {
        if ([_dataArray[indexPath.row] isEqualToString:@"常见问题"])
        {
            [self FAQ];
        }
        else if([_dataArray[indexPath.row] isEqualToString:@"关于我们"])
        {
            [self aboutUs];
        }
        else if([_dataArray[indexPath.row] isEqualToString:@"修改密码"])
        {
            [self changePassword];
        }
        else if([_dataArray[indexPath.row] isEqualToString:@"意见反馈"])
        {
            [self feedBack];
        }
        else if([_dataArray[indexPath.row] isEqualToString:@"退出当前账户"])
        {
            [self queit];
        }
        
    }
}
-(void)changeUserInfo
{
    ChangeUserInfoViewController *changeuserinfoVc = [[ChangeUserInfoViewController alloc]init];
    changeuserinfoVc.title = @"修改个人信息";
    changeuserinfoVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:changeuserinfoVc animated:YES];
    changeuserinfoVc.block = ^(NSDictionary *dic) {
        _name =dic[@"姓名"];
        _userSchool = dic[@"学校"];
        _teacherID = dic[@"教工号"];
        userImage = [dic[@"info"] objectForKey:UIImagePickerControllerEditedImage];
        if (userImage)
        {
            //获取图片尺寸
            CGSize size = userImage.size;
            
            //开启位图上下文
            UIGraphicsBeginImageContextWithOptions(size, NO, 0);
            
            //创建圆形路径
            UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, userImage.size.width, userImage.size.height)];
            
            //设置为裁剪区域
            [path addClip];
            
            //绘制图片
            [userImage drawAtPoint:CGPointZero];
            
            //获取裁剪后的图片
            imageview.image = UIGraphicsGetImageFromCurrentImageContext();
            
            //关闭上下文
            UIGraphicsEndImageContext();
        }
        else
        {
            imageview.image = [UIImage imageNamed:@"头像"];
        }
        
        
        [myTableView reloadData];
    };
    
}

-(void)FAQ
{
    FAQViewController *FAQvc = [[FAQViewController alloc]init];
    FAQvc.title = @"常见问题";
    FAQvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:FAQvc animated:YES];
}
-(void)aboutUs
{
    AboutUsViewController *aboutUsVc = [[AboutUsViewController alloc]init];
    aboutUsVc.title = @"关于我们";
    aboutUsVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:aboutUsVc animated:YES];
}
-(void)changePassword
{
    ChangePasswordViewController *changepassworeVc = [[ChangePasswordViewController alloc]init];
    changepassworeVc.title = @"修改密码";
    changepassworeVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:changepassworeVc animated:YES];
}
-(void)queit
{
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:@"确定退出登录？" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UserManager *manager = [UserManager sharedUserManager];
        [manager logOut];
        LoginViewController *loginVc = [[LoginViewController alloc]init];
        self.view.window.rootViewController = loginVc;
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertVc addAction:confirmAction];
    [alertVc addAction:cancelAction];
    [self presentViewController:alertVc animated:YES completion:nil];
}
-(void)feedBack
{
    FeedBackViewController *feedbackVc = [[FeedBackViewController alloc]init];
    feedbackVc.title = @"意见反馈";
    feedbackVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:feedbackVc animated:YES];
}
@end
