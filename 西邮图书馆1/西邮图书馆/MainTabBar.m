//
//  MainTabBar.m
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/1/13.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import "MainTabBar.h"
#import "HomePageViewController.h"
#import "MyViewController.h"
#import "SettingViewController.h"
#import "LMKNavigationVc.h"
@interface MainTabBar ()

@end

@implementation MainTabBar

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置分栏控制器的背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tabBar setBarTintColor:[UIColor colorWithRed:243/256.0 green:92/256.0 blue:90/256.0 alpha:1]];
    [self.tabBar setTintColor:[UIColor whiteColor]];
    self.tabBar.translucent = NO;
    

    HomePageViewController *homevc = [[HomePageViewController alloc]init];
    [self createVC:homevc Title:@"首页" imageName:@"首页"];
    
    MyViewController *myvc = [[MyViewController alloc]init];
    [self createVC:myvc Title:@"我的" imageName:@"我的"];
    
    SettingViewController *setvc = [[SettingViewController alloc]init];
    [self createVC:setvc Title:@"设置" imageName:@"设置"];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
 *函数作用：将分栏控制器的每个字控制器加入分栏控制器并设置标题及背景图片
 *参数一：子视图控制器
 *参数二：标题名称
 *参数三：背景图片名称
 */
- (void)createVC:(UIViewController *)vc Title:(NSString *)title imageName:(NSString *)imageName
{
    vc.title = title;
    
    //设置正常状态下该视图控制器所对应按钮的背景图片
    vc.tabBarItem.image = [[UIImage imageNamed:imageName]imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    //设置选中状态下该视图控制器所对应按钮的背景图片
    NSString *imageSelect = [NSString stringWithFormat:@"%@-按下",imageName];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:imageSelect]imageWithRenderingMode: UIImageRenderingModeAlwaysTemplate];
    
    //设置tabbaritm上面正常和选中状态下文字的颜色
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateNormal];
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateSelected];
    
    //用导航控制器包装子视图
    LMKNavigationVc *nvc = [[LMKNavigationVc alloc]initWithRootViewController:vc];
    [self addChildViewController:nvc];
}
@end
