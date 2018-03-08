//
//  FAQViewController.m
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/1/22.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import "FAQViewController.h"
#import <Masonry.h>
@interface FAQViewController ()

@end

@implementation FAQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)loadView
{
    [super loadView];
    [self loaaSubviews];
}

-(void)loaaSubviews
{
    self.title = @"常见问题";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *FAQLabel1 = [[UILabel alloc]init];
    FAQLabel1.text = @"\n 1.登录时的学号和密码指的是？\n    学号即各位同学在本校图书馆系统时所使用的学号，密码即登录本校图书馆系统所使用的密码。\n";
    FAQLabel1.numberOfLines = 0;
    FAQLabel1.font = [UIFont systemFontOfSize:15];
    FAQLabel1.layer.cornerRadius = 10;
    FAQLabel1.layer.masksToBounds = YES;
 //   FAQLabel1.clipsToBounds = YES;
    FAQLabel1.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self.view addSubview:FAQLabel1];
    
    UILabel *FAQLabel2 = [[UILabel alloc]init];
    FAQLabel2.text = @"\n 2.学号和密码安全吗？\n   为了提高查询速度和缓解服务器压力，我们只对一些图书信息进行了缓存，但不针对任何用户信息，请放心使用\n";
    FAQLabel2.numberOfLines = 0;
    FAQLabel2.font = [UIFont systemFontOfSize:15];
    FAQLabel2.layer.cornerRadius = 10;
    FAQLabel2.layer.masksToBounds = YES;
    FAQLabel2.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self.view addSubview:FAQLabel2];
    
    [FAQLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.top.equalTo(self.view.mas_top).offset(10);
        make.width.mas_equalTo(@150);
    }];
    [FAQLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.top.equalTo(FAQLabel1.mas_bottom).offset(10);
        make.width.mas_equalTo(@150);
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
