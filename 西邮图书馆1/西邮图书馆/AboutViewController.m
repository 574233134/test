//
//  AboutViewController.m
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/1/22.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import "AboutViewController.h"
#import <Masonry.h>
@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)loadView
{
    [super loadView];
    [self loadSubview];
}
-(void)loadSubview
{
    self.title = @"关于我们";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *iconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"应用图标"]];
    [self.view addSubview:iconView];
    
    
    UILabel *versionLabel = [[UILabel alloc]init];
    versionLabel.text = @"西邮图书馆 V1.0.2";
    versionLabel.textColor = [UIColor colorWithRed:243/256.0 green:92/256.0 blue:90/256.0 alpha:1];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:versionLabel];
    
    UILabel *departmentLabel = [[UILabel alloc]init];
    departmentLabel.text=@"Copyright ©2015-2017 西安邮电大学移动开发实验室iOS组";
    departmentLabel.textAlignment = NSTextAlignmentCenter;
    departmentLabel.textColor = [UIColor colorWithRed:243/256.0 green:92/256.0 blue:90/256.0 alpha:1];
    departmentLabel.font = [UIFont systemFontOfSize:11];
    [self.view addSubview:departmentLabel];
    
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(20);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(iconView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(150, 40));
    }];
    [departmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).offset(-8);
        make.size.mas_equalTo(CGSizeMake(300, 30));
    }];
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
