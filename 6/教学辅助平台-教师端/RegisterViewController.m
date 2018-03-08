//
//  RegisterViewController.m
//  教学辅助平台-教师端
//
//  Created by 李梦珂 on 2018/1/1.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "UserManager.h"
#import <Masonry.h>
@interface RegisterViewController ()

@end

@implementation RegisterViewController
{
    UITextField *userNameTextfield;
    UITextField *passWordTextfield;
    UITextField *passWordTextfield2;
    UIButton *registerButton;
    UIButton *cancelButton;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"注册";
    [self loadSubviews];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    userNameTextfield.text = @"";
    passWordTextfield.text = @"";
    passWordTextfield2.text = @"";
}
-(void)loadSubviews
{
    
    UILabel *userRister = [[UILabel alloc]init];
    userRister.font = [UIFont systemFontOfSize:30];
    userRister.text = @"新用户注册";
    userRister.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:userRister];
    [userRister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(30);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(200, 50));
    }];
    UILabel * userName = [[UILabel alloc]init];
    userName.text = @"账号";
    [self.view addSubview:userName];
    [userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.top.equalTo(userRister.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(70, 30));
    }];
    
    userNameTextfield = [[UITextField alloc]init];
    userNameTextfield.placeholder = @"请输入账号";
    userNameTextfield.delegate = self;
    [userNameTextfield addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:userNameTextfield];
    [userNameTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userName.mas_right).offset(20);
        make.top.equalTo(userName.mas_top);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width-120, 30));
    }];
    
    UIImageView *line1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line"]];
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userName.mas_left);
        make.top.equalTo(userName.mas_bottom).offset(3);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width-30, 2));
    }];
    
    UILabel *password1 = [[UILabel alloc]init];
    password1.text=@"密码";
    [self.view addSubview:password1];
    [password1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userName.mas_left);
        make.top.equalTo(line1.mas_bottom).offset(3);
        make.size.mas_equalTo(CGSizeMake(70, 30));
    }];
    
    passWordTextfield = [[UITextField alloc]init];
    passWordTextfield.placeholder = @"请输入密码";
    passWordTextfield.secureTextEntry = YES;
    passWordTextfield.delegate = self;
    [passWordTextfield addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:passWordTextfield];
    [passWordTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(password1.mas_right).offset(20);
        make.top.equalTo(password1.mas_top);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width-120, 30));
    }];
    
    UIImageView *line2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line"]];
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(password1.mas_left);
        make.top.equalTo(password1.mas_bottom).offset(3);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width-30, 2));
    }];
    
    UILabel *password2 = [[UILabel alloc]init];
    password2.text = @"确认密码";
    [self.view addSubview:password2];
    [password2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userName.mas_left);
        make.top.equalTo(line2.mas_bottom).offset(3);
        make.size.mas_equalTo(CGSizeMake(70, 30));
    }];
    
    passWordTextfield2 = [[UITextField alloc]init];
    passWordTextfield2.placeholder = @"再次输入密码";
    passWordTextfield2.delegate = self;
    passWordTextfield2.secureTextEntry = YES;
    [passWordTextfield2 addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:passWordTextfield2];
    [passWordTextfield2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(password2.mas_right).offset(20);
        make.top.equalTo(password2.mas_top);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width-120, 30));
    }];
    
    UIImageView *line3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line"]];
    [self.view addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userName.mas_left);
        make.top.equalTo(password2.mas_bottom).offset(3);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width-30, 2));
    }];
    
    registerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [registerButton setTintColor:[UIColor whiteColor]];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    registerButton.layer.cornerRadius = 5;
    registerButton.backgroundColor = [UIColor colorWithRed:243/256.0 green:92/256.0 blue:90/256.0 alpha:0.7];
    registerButton.userInteractionEnabled = NO;
    [registerButton addTarget:self action:@selector(registerUser) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userName.mas_left);
        make.top.equalTo(line3.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width-30, 40));
    }];
    
//    cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [cancelButton setTintColor:[UIColor colorWithRed:243/256.0 green:92/256.0 blue:90/256.0 alpha:0.5]];
//    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
//    cancelButton.layer.cornerRadius = 5;
//    cancelButton.layer.borderWidth = 1;
//    cancelButton.layer.borderColor =[UIColor colorWithRed:243/256.0 green:92/256.0 blue:90/256.0 alpha:0.5].CGColor;
//
//    [cancelButton addTarget:self action:@selector(cancelRegister) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:cancelButton];
//    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(registerButton.mas_left);
//        make.top.equalTo(registerButton.mas_bottom).offset(15);
//        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width-60, 40));
//    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelRegister)];

}
-(void)cancelRegister
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
-(void)valueChanged
{
    if ([userNameTextfield.text isEqualToString:@""]||[passWordTextfield.text isEqualToString:@""]||[passWordTextfield2.text isEqualToString:@""])
    {
        registerButton.backgroundColor = [UIColor colorWithRed:243/256.0 green:92/256.0 blue:90/256.0 alpha:0.7];
        registerButton.userInteractionEnabled = NO;
        
    }
    else
    {
        
        registerButton.backgroundColor = [UIColor colorWithRed:243/256.0 green:92/256.0 blue:90/256.0 alpha:1];
        registerButton.userInteractionEnabled = YES;
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [userNameTextfield resignFirstResponder];
    [passWordTextfield resignFirstResponder];
    [passWordTextfield2 resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)registerUser
{
    [userNameTextfield resignFirstResponder];
    [passWordTextfield resignFirstResponder];
    [passWordTextfield2 resignFirstResponder];
    UserManager *manger = [UserManager sharedUserManager];
    if ( ![self isLegalUsername])
    {
        [self alertWithTitle:@"用户名格式不正确！" massage:@"用户名长度4~18个字符，可包含数字、字母及符号，不包含空格"];
    }
    else
    {
        if ([self getPassWordCorrectCode] == -1)
        {
            [self alertWithTitle:@"两次密码不一致！" massage:@"请重新输入"];
        }
        else if ([self getPassWordCorrectCode] == -2)
        {
            [self alertWithTitle:@"密码格式不正确！" massage:@"密码长度6~14个字符，可包含数字、字母及符号，不包含空格"];
        }
        else
        {
            [manger toRegister:userNameTextfield.text with:passWordTextfield.text block:^(int result) {
                NSLog(@"%d",result);
                if(result == 0)//失败0
                {
                    [self alertWithTitle:@"注册失败!" massage:@"请检查网络后重试"];
                }
                else if(result == -1)//用户存在-1
                {
                    [self alertWithTitle:@"用户已存在！" massage:@"请重新注册"];
                }
                else //成功1
                {
                    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"注册成功!" message:nil preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        //注册成功后返回登录界面
                        [self dismissViewControllerAnimated:YES completion:nil];            }];
                    [alertVc addAction:okAction];
                    [self presentViewController:alertVc animated:YES completion:nil];
                    
                    
                }
                
            }];
        }
    }
    
}
-(BOOL)isLegalUsername
{
    if (userNameTextfield.text.length<4||userNameTextfield.text.length>18||[self isHavingEmptyString:userNameTextfield.text])
    {
        return 0; // 用户名格式不正确
    }
    else
    {
        return 1;
    }
}
-(NSInteger)getPassWordCorrectCode
{
    if (![passWordTextfield.text isEqualToString:passWordTextfield2.text]) {
        return -1; //两次密码输入不一致；
    }
    else if (passWordTextfield.text.length<6||passWordTextfield.text.length>14||[self isHavingEmptyString:passWordTextfield.text])
    {
        return -2;//密码格式不正确；
    }
    else
        return 1; //合法密码
}
//判断字符串是否含有空格
-(BOOL)isHavingEmptyString:(NSString *)string
{
    NSRange range = [string rangeOfString:@" "];
    if (range.location!=NSNotFound) {
        return YES;
    }
    else
        return NO;
}

-(void)alertWithTitle:(NSString *)title massage:(NSString *)massage
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:title message:massage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVc addAction:okAction];
    [self presentViewController:alertVc animated:YES completion:nil];
}
#pragma textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
