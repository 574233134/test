//
//  AboutUsViewController.m
//  教学辅助平台-教师端
//
//  Created by 李梦珂 on 2018/1/3.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "AboutUsViewController.h"
#import <Masonry.h>
@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)loadView
{
    [super loadView];
    [self loadSubviews];
}
-(void)loadSubviews
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *iconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"appLogo"]];
    [self.view addSubview:iconView];
    
    
    UILabel *versionLabel = [[UILabel alloc]init];
    versionLabel.text = @"教学辅助系统 V1.0.0";
    versionLabel.textColor = [UIColor colorWithRed:243/256.0 green:92/256.0 blue:90/256.0 alpha:1];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:versionLabel];
    
    UILabel *departmentLabel = [[UILabel alloc]init];
    departmentLabel.text=@"Copyright ©2017 西安邮电大学WINCE3+1";
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
        make.top.equalTo(iconView.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(200, 40));
    }];
    [departmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).offset(-8);
        make.size.mas_equalTo(CGSizeMake(280, 30));
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
