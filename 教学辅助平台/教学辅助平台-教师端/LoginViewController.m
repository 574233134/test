//
//  LoginViewController.m
//  教学辅助平台-教师端
//
//  Created by 李梦珂 on 2018/1/1.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "MainTabBarController.h"
#import "MyNavigationController.h"
#import "UserManager.h"
#import <Masonry.h>
@interface LoginViewController ()

@end

@implementation LoginViewController
{
    UITextField * userName;
    UITextField * passWord;
    UIButton *loginButton;
}
- (void)viewDidLoad
{
    [super viewDidLoad];

}
-(void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadSubViews];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    userName.text = @"";
    passWord.text = @"";
}
-(void)loadSubViews
{
    UIImageView *appLogoView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"appLogo"]];
    [self.view addSubview:appLogoView];
    
    [appLogoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(60);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    UILabel *userLabel = [[UILabel alloc]init];
    userLabel.text = @"账号";
    [self.view addSubview:userLabel];
    [userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.top.equalTo(appLogoView.mas_bottom).offset(40);
        make.size.mas_equalTo(CGSizeMake(40, 30));
    }];
    
    userName = [[UITextField alloc]init];
    userName.placeholder = @"请输入账号";
    userName.delegate = self;
    [userName addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:userName];
    [userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userLabel.mas_right).offset(10);
        make.top.equalTo(userLabel.mas_top);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width-180, 30));
    }];
    
    UIImageView *line1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line"]];
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.top.equalTo(userName.mas_bottom).offset(3);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width-30, 2));
    }];
    
    UILabel *passwordLabel = [[UILabel alloc]init];
    passwordLabel.text = @"密码";
    [self.view addSubview:passwordLabel];
    [passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom).offset(3);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(40, 30));
    }];

    passWord = [[UITextField alloc]init];
    passWord.placeholder = @"请输入登录密码";
    passWord.secureTextEntry = YES;
    passWord.delegate = self;
    [passWord addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:passWord];
    [passWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passwordLabel.mas_right).offset(10);
        make.top.equalTo(passwordLabel.mas_top);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width-180, 30));
    }];

    UIImageView *line2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line"]];
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passwordLabel.mas_left);
        make.top.equalTo(passwordLabel.mas_bottom).offset(3);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width-30, 2));
    }];
    
    loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    loginButton.layer.cornerRadius = 5;
    loginButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [loginButton setTintColor:[UIColor whiteColor]];
    loginButton.userInteractionEnabled = NO;
    loginButton.backgroundColor = [UIColor colorWithRed:243/256.0 green:92/256.0 blue:90/256.0 alpha:0.7];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line2.mas_left);
        make.top.equalTo(line2.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width-30, 40));
    }];

    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    moreButton.backgroundColor = [UIColor clearColor];
    [moreButton setTitle:@"更多" forState:UIControlStateNormal];
    [moreButton setTintColor:[UIColor colorWithRed:243/256.0 green:92/256.0 blue:90/256.0 alpha:1]];
    [moreButton addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:moreButton];
    [moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
}
-(void)valueChanged
{
    if ([userName.text isEqualToString:@""]||[passWord.text isEqualToString:@""])
    {
        loginButton.backgroundColor = [UIColor colorWithRed:243/256.0 green:92/256.0 blue:90/256.0 alpha:0.7];
        loginButton.userInteractionEnabled = NO;
        
    }
    else
    {
        
        loginButton.backgroundColor = [UIColor colorWithRed:243/256.0 green:92/256.0 blue:90/256.0 alpha:1];
        loginButton.userInteractionEnabled = YES;
    }
}

-(void)login
{
    [userName resignFirstResponder];
    [passWord resignFirstResponder];
    UserManager *manager = [UserManager sharedUserManager];
    [manager logInUser:userName.text with:passWord.text block:^(int result) {
        if (result ==0)// 查表失败
        {
            [self alertwithTitle:@"登录失败" andMessage:@"请检查网络后重试"];
        }
        else if (result == 1) // 登录成功
        {
            UserManager *manger = [UserManager sharedUserManager];
            [manger updateUserInfoFromBackgroundWithblock:^(int result) {
                if (result)
                {
                    MainTabBarController *mainVc = [[MainTabBarController alloc]init];
                    self.view.window.rootViewController = mainVc;
                }
            }];
            
        }
        else if (result == -1) // 用户名不存在
        {
            [self alertwithTitle:@"用户名不存在!" andMessage:@"请先进行注册"];
        }
        else // 密码错误
        {
            [self alertwithTitle:@"用户名或密码错误！" andMessage:@"请重新输入"];
        }
    }];

}
-(void)alertwithTitle:(NSString *)title andMessage:(NSString *)massage
{
    UIAlertController *alertVc =[UIAlertController alertControllerWithTitle:title message:massage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertVc addAction:okAction];
    [self presentViewController:alertVc animated:YES completion:nil];
}
-(void)more
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"" message:@"是否要注册?" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *registerAction = [UIAlertAction actionWithTitle:@"注册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        RegisterViewController *registerVc = [[RegisterViewController alloc]init];
        MyNavigationController *nvc = [[MyNavigationController alloc]initWithRootViewController:registerVc];
        [self presentViewController:nvc animated:YES completion:nil];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
    }];
    [alertVc addAction:registerAction];
    [alertVc addAction:cancelAction];
    [self presentViewController:alertVc animated:YES completion:nil];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [userName resignFirstResponder];
    [passWord resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
#pragma textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
