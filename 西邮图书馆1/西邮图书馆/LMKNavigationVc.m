//
//  LMKNavigationVc.m
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/1/13.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import "LMKNavigationVc.h"

@interface LMKNavigationVc ()

@end

@implementation LMKNavigationVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
    [self.navigationBar setBarTintColor:[UIColor colorWithRed:243/256.0 green:92/256.0 blue:90/256.0 alpha:1]];
    //设置navigationbar字体颜色
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //设置字体颜色iOS 5.0
//    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor ,nil]];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
