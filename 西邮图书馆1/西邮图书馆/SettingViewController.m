//
//  SettingViewController.m
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/1/13.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import "SettingViewController.h"
#import "Publicinfo.h"
#import "FAQViewController.h"
#import "AboutViewController.h"
#import "ChangeViewController.h"
@interface SettingViewController ()

@end

@implementation SettingViewController
{
    UITableView *settingtableview;
    UISwitch *expirationtips;
    UISwitch *showPic;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(instancetype)init
{
    self = [super init];
    if (self) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [self enterSetting];
}
-(void)enterSetting
{
    if ([Publicinfo getCurrentAccount]==nil||[[Publicinfo getCurrentAccount] isEqualToString:@""]) {
        [_dataArray setArray:[NSArray arrayWithObjects:@"常见问题",@"关于我们", nil]];
    }
    else
    {
        [_dataArray setArray:[NSArray arrayWithObjects:@"到期提示",@"2G/3G/4G下显示图片",@"常见问题",@"关于我们",@"修改密码",@"退出当前账户", nil]];
    }
    [settingtableview reloadData];
}
-(void)loadView
{
    [super loadView];
    settingtableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-49) style:UITableViewStyleGrouped];
    settingtableview.bounces = NO;
    settingtableview.dataSource = self;
    settingtableview.delegate = self;
    [self.view addSubview:settingtableview];
    
    expirationtips = [[UISwitch alloc]init];
    showPic = [[UISwitch alloc]init];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadAlert
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否退出当前账户？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [Publicinfo deleteUserNameAndPassword];
        [settingtableview reloadData];
        [self enterSetting];
    }]];

    [self presentViewController:alertController animated:YES completion:^{}];
}
#pragma tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.accessoryView = nil;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _dataArray[indexPath.row];
    if([_dataArray[indexPath.row] isEqualToString:@"常见问题"]||[_dataArray[indexPath.row] isEqualToString:@"关于我们"]||[_dataArray[indexPath.row] isEqualToString:@"修改密码"]||[_dataArray[indexPath.row] isEqualToString:@"退出当前账户"])
    {
        //设置cell右侧的箭头
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    else if([_dataArray[indexPath.row] isEqualToString:@"到期提示"])
    {
        [expirationtips setOn:[Publicinfo getExpirationTip]];
        [expirationtips addTarget:self action:@selector(expirationTip) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = expirationtips;
    }
    else if([_dataArray[indexPath.row] isEqualToString:@"2G/3G/4G下显示图片"])
    {
        [showPic setOn:[Publicinfo getShowPic]];
        [showPic addTarget:self action:@selector(showPic) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = showPic;
    }
    return cell;
}

#pragma tableview delagete
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([_dataArray[indexPath.row] isEqualToString:@"到期提示"])//到期提示
    {
        
    }
    else if([_dataArray[indexPath.row] isEqualToString:@"2G/3G/4G下显示图片"])//2G/3G/4G下显示图片
    {
        
    }
    else if ([_dataArray[indexPath.row] isEqualToString:@"常见问题"])//常见问题
    {
        FAQViewController *faqvc = [[FAQViewController alloc]init];
        faqvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:faqvc animated:YES];
    }
    else if ([_dataArray[indexPath.row] isEqualToString:@"关于我们"])//关于我们
    {
        AboutViewController *about = [[AboutViewController alloc]init];
        about.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:about animated:YES];
    }
    else if ([_dataArray[indexPath.row] isEqualToString:@"修改密码"])//修改密码
    {
        ChangeViewController *changevc = [[ChangeViewController alloc]init];
        changevc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:changevc animated:YES];
    }
    else if ([_dataArray[indexPath.row] isEqualToString:@"退出当前账户"])//退出当前账户
    {
        [self loadAlert];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
#pragma 到期提示开关事件
-(void)expirationTip
{
    [Publicinfo setExpirationTip:expirationtips.on];
}
#pragma 2G/3G/4G下显示图片
-(void)showPic
{
    [Publicinfo setExpirationTip:showPic.on];
}
@end
