//
//  MainTabBarController.m
//  教学辅助平台-教师端
//
//  Created by 李梦珂 on 2017/12/30.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import "MainTabBarController.h"
#import "ClassViewController.h"
#import "UploadViewController.h"
#import "MyViewController.h"
#import "MyNavigationController.h"
@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tabBar setBarTintColor:[UIColor colorWithRed:243/256.0 green:92/256.0 blue:90/256.0 alpha:1]];
    [self.tabBar setTintColor:[UIColor whiteColor]];
    self.tabBar.unselectedItemTintColor = [UIColor whiteColor];
    self.tabBar.translucent = NO;
    ClassViewController *classVc = [[ClassViewController alloc]init];
    [self createVC:classVc Title:@"课堂" imageName:@"课堂"];
    UploadViewController *uploadVc = [[UploadViewController alloc]init];
    [self createVC:uploadVc Title:@"帖子" imageName:@"上传"];
    MyViewController  *myVc = [[MyViewController alloc]init];
    [self createVC:myVc Title:@"我的" imageName:@"我的"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)createVC:(UIViewController *)vc Title:(NSString *)title imageName:(NSString *)imageName
{
    vc.title = title;
    
    //用导航控制器包装子视图
    MyNavigationController *nvc = [[MyNavigationController alloc]initWithRootViewController:vc];
    nvc.tabBarItem.image = [[UIImage imageNamed:imageName]imageWithRenderingMode:  UIImageRenderingModeAutomatic];
    //设置选中状态下该视图控制器所对应按钮的背景图片
    NSString *imageSelect = [NSString stringWithFormat:@"%@_按下",imageName];
    nvc.tabBarItem.selectedImage = [[UIImage imageNamed:imageSelect]imageWithRenderingMode: UIImageRenderingModeAutomatic];
    
    //设置tabbaritm上面正常和选中状态下文字的颜色
    //[vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateNormal];
    //[nvc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateSelected];

    [self addChildViewController:nvc];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
