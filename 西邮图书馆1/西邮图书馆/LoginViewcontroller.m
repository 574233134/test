//
//  LoginViewcontroller.m
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/1/19.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import "LoginViewcontroller.h"
#import "Publicinfo.h"
#import <Masonry.h>
#import <AFNetworking.h>
@interface LoginViewcontroller ()

@end

@implementation LoginViewcontroller
{
    UILabel *leftuser;
    UILabel *leftPassword;
    UITextField *usernameTextField;
    UITextField *passwordTextField;
    UIButton *loginButton;
    UIView *loginView;
}
-(void)loadView
{
    [super loadView];
    [self loadsubview];
}
-(void)loadsubview
{
    //设置标题文字及颜色
    self.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dissmiss)];
    
    leftuser = [[UILabel alloc]init];
    leftuser.text = @"用户名:";
    [self.view addSubview:leftuser];
    leftPassword = [[UILabel alloc]init];
    leftPassword.text = @"密   码:";
    [self.view addSubview:leftPassword];
    
    usernameTextField = [[UITextField alloc]init];
    usernameTextField.placeholder = @"请输入用户名";
    usernameTextField.font = [UIFont systemFontOfSize:15];
    usernameTextField.layer.cornerRadius = 5;
    usernameTextField.delegate = self;
    [usernameTextField addTarget:self action:@selector(valueChange) forControlEvents:UIControlEventEditingChanged];
    usernameTextField.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    [self.view addSubview:usernameTextField];
    passwordTextField = [[UITextField alloc]init];
    passwordTextField.placeholder = @"请输入密码";
    passwordTextField.font = [UIFont systemFontOfSize:15];
    passwordTextField.secureTextEntry = YES;
    passwordTextField.layer.cornerRadius = 5;
    passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordTextField.delegate = self;
    [passwordTextField addTarget:self action:@selector(valueChange) forControlEvents:UIControlEventEditingChanged];
    passwordTextField.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    [self.view addSubview:passwordTextField];
    
    
    loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:loginButton];
    loginButton.layer.cornerRadius = 5;
    loginButton.backgroundColor = [UIColor colorWithRed: 243/256.0 green:92/256.0 blue:90/256.0 alpha:0.5];
    loginButton.userInteractionEnabled = NO;
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(press) forControlEvents:UIControlEventTouchUpInside];
    
    loginView = [[UIView alloc]init];
    loginView.hidden = YES;
    [self.view addSubview:loginView];
    UILabel *lable = [[UILabel alloc]init];
    lable.text = @"登录中...";
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = [UIFont systemFontOfSize:15];
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activity startAnimating];
    [loginView addSubview:lable];
    [loginView addSubview:activity];
    [leftuser mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.top.equalTo(self.view.mas_top).offset(30);
        make.size.mas_equalTo(CGSizeMake(70, 30));
    }];
    
    [usernameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftuser.mas_right).offset(0);
        make.top.equalTo(leftuser.mas_top);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.bottom.equalTo(leftuser.mas_bottom);
    }];
    [leftPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftuser.mas_left);
        make.top.equalTo(leftuser.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(70, 30));
    }];
    [passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftPassword.mas_right).offset(0);
        make.right.equalTo(usernameTextField.mas_right);
        make.top.equalTo(usernameTextField.mas_bottom).offset(10);
        make.height.mas_equalTo(leftPassword.mas_height);
    }];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.top.equalTo(leftPassword.mas_bottom).offset(10);
        make.bottom.equalTo(leftPassword.mas_bottom).offset(50);
    }];
    [loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(loginButton.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(loginView.mas_top).offset(100);
        make.size.mas_equalTo(CGSizeMake(60, 40));
    }];
    [activity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lable.mas_top);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [usernameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)dissmiss
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
-(void)press
{
    loginView.hidden = NO;
    [self login];
}
-(void)login
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *basestring = [NSString stringWithFormat:@"http://api.xiyoumobile.com/xiyoulibv2/user/login?username=S%@&password=%@",usernameTextField.text,passwordTextField.text];
    [manager GET:basestring parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        loginView.hidden = YES;
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSString * result = [resultDic objectForKey:@"Result"];
        NSInteger resultcode = [result integerValue];
        if (resultcode == 0) {
            //用户名或密码错误
            loginView.hidden = YES;
            [self alerthTitle:@"提示" massage:@"用户名或密码错误"];

        }
        else
        {
            //登陆成功
            NSString *session = [[resultDic objectForKey:@"Detail"] stringByReplacingOccurrencesOfString:@" " withString:@""];
            [Publicinfo sharedPublicinfo].session = session;
            [Publicinfo saveUserName:usernameTextField.text password:passwordTextField.text];
            [self loginInfo];
        }
            
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        loginView.hidden = YES;
        [self alerthTitle:@"登录失败" massage:@"请检查网络"];
    }];
}
-(void)loginInfo
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *basestring = [NSString stringWithFormat:@"http://api.xiyoumobile.com/xiyoulibv2/user/info?session=%@",[Publicinfo sharedPublicinfo].session];
    [manager GET:basestring parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [usernameTextField resignFirstResponder];
        [passwordTextField resignFirstResponder];
        loginView.hidden = YES;
        [Publicinfo setMyData:resultDic[@"Detail"]];
        [self dismissViewControllerAnimated:YES completion:^{}];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        loginView.hidden = YES;
        [self alerthTitle:@"加载失败" massage:@"请检查网络"];
    }];

}
-(void)alerthTitle:(NSString *) title massage:(NSString *) massage
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:massage preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}]];
    [self presentViewController:alertController animated:YES completion:^{}];
}

-(void)valueChange
{
    if ([usernameTextField.text isEqualToString:@""]||[passwordTextField.text isEqualToString:@""]) {
        loginButton.backgroundColor = [UIColor colorWithRed: 243/256.0 green:92/256.0 blue:90/256.0 alpha:0.5];
        loginButton.userInteractionEnabled = NO;
    }
    else
    {
        loginButton.backgroundColor = [UIColor colorWithRed: 243/256.0 green:92/256.0 blue:90/256.0 alpha:1];
        loginButton.userInteractionEnabled = YES;
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma textfield delagete
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
