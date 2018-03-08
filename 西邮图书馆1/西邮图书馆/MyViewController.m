//
//  MyViewController.m
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/1/13.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import "MyViewController.h"
#import "LoginViewcontroller.h"
#import "LMKNavigationVc.h"
#import "Publicinfo.h"
#import "FootprintViewController.h"
#import "MyCollectionViewController.h"
#import "MyBorrowViewController.h"
#import <Masonry.h>
@interface MyViewController ()

@end

@implementation MyViewController
{
    UITableView *tableview;
}
- (void)viewDidLoad {
    [super viewDidLoad];

}
-(instancetype)init
{
    self = [super init];
    if (self) {
        self.dataarray = [[NSMutableArray alloc]initWithObjects:@"我的借阅",@"我的收藏",@"我的足迹", nil];
    }
    return self;
}
-(void)loadView
{
    [super loadView];
   
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSArray *Subviews = [self.view subviews];
    for (int i=0; i<Subviews.count; i++) {
        [Subviews[i] removeFromSuperview];
    }
    if ([[Publicinfo getCurrentAccount] isEqualToString:@""]||[Publicinfo getCurrentAccount]==nil) {
        [self notLogin];
    }
    else
    {
        [self alreadyLogin];
    }
    
}
-(void)notLogin
{
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    loginButton.layer.borderWidth = 2;
    loginButton.layer.cornerRadius = 8;
    loginButton.layer.borderColor = [UIColor grayColor].CGColor;
    [loginButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)alreadyLogin
{
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    tableview.bounces = NO;
    tableview.dataSource = self;
    tableview.delegate = self;
    [self.view addSubview:tableview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
-(void)login
{
    LoginViewcontroller *loginvc = [[LoginViewcontroller alloc]init];
    LMKNavigationVc *nv = [[LMKNavigationVc alloc]initWithRootViewController:loginvc];
    [self presentViewController:nv animated:YES completion:nil];
}
-(void)loadSection0:(UITableViewCell *)cell
{
    UIImageView *imageview= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"西安邮电大学校徽"]];
    [cell.contentView addSubview:imageview];
    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.mas_left).offset(10);
        make.top.equalTo(cell.mas_top).offset(5);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    
    NSDictionary *dataDic = [Publicinfo getMyData];
    
    UILabel *name = [[UILabel alloc]init];
    [cell.contentView addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageview.mas_right).offset(20);
        make.top.equalTo(imageview.mas_top);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    name.font = [UIFont systemFontOfSize:20];
    name.text = dataDic[@"Name"];
    
    
    UILabel *userclass = [[UILabel alloc]init];
    [cell.contentView addSubview:userclass];
    [userclass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageview.mas_right).offset(20);
        make.top.equalTo(name.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    userclass.font = [UIFont systemFontOfSize:14];
    userclass.text = dataDic[@"Department"];
   
    
    UILabel *studentID = [[UILabel alloc]init];
    [cell.contentView addSubview:studentID];
    [studentID mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userclass.mas_right).offset(10);
        make.top.equalTo(userclass.mas_top);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];

    studentID.font = [UIFont systemFontOfSize:14];
    studentID.text = [dataDic[@"ID"] stringByReplacingOccurrencesOfString:@"S" withString:@""];
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
        return 3;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:identify];
    if(!cell)
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
        cell.textLabel.text = _dataarray[indexPath.row];
        //设置cell右侧的箭头
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}
#pragma tableview delagete
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
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
    if(indexPath.section == 1)
    {
        if ([_dataarray[indexPath.row] isEqualToString:@"我的借阅"])
        {
            MyBorrowViewController *myborrowvc = [[MyBorrowViewController alloc]init];
            myborrowvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:myborrowvc animated:YES];
        }
        else if([_dataarray[indexPath.row] isEqualToString:@"我的收藏"])
        {
            MyCollectionViewController *collectionvc = [[MyCollectionViewController alloc]init];
            collectionvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:collectionvc animated:YES];
        }
        else if([_dataarray[indexPath.row] isEqualToString:@"我的足迹"])
        {
            FootprintViewController *footvc = [[FootprintViewController alloc]init];
            footvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:footvc animated:YES];
        }
    }
}
@end
