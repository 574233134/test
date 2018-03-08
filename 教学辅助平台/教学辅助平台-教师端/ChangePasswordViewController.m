//
//  ChangePasswordViewController.m
//  教学辅助平台-教师端
//
//  Created by 李梦珂 on 2018/1/3.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "UserManager.h"
#import <Masonry.h>
@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController
{
    UITextField *newPassWordTextfield1;
    UITextField *newPassWordTextfield2;
    UIButton *okButton;
}

-(void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor colorWithRed:245/256.0 green:245/256.0 blue:245/256.0 alpha:1];
    [self loadSubviews];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    newPassWordTextfield1.text = @"";
    newPassWordTextfield2.text = @"";
}
-(void)loadSubviews
{
    UIView *backgroundview = [[UIView alloc]init];
    backgroundview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundview];
    [backgroundview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.view.mas_top).offset(30);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, 88));
    }];
    
    UILabel *newpassword1 = [[UILabel alloc]init];
    newpassword1.text=@"新密码";
    [self.view addSubview:newpassword1];
    [newpassword1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backgroundview.mas_left).offset(15);
        make.top.equalTo(backgroundview.mas_top).offset(0);
        make.size.mas_equalTo(CGSizeMake(70, 43));
    }];
    
    newPassWordTextfield1 = [[UITextField alloc]init];
    newPassWordTextfield1.placeholder = @"请输入密码";
    newPassWordTextfield1.secureTextEntry = YES;
    newPassWordTextfield1.delegate = self;
    [newPassWordTextfield1 addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:newPassWordTextfield1];
    [newPassWordTextfield1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(newpassword1.mas_right).offset(10);
        make.top.equalTo(newpassword1.mas_top);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width-110, 43));
    }];
    
    UIImageView *line2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line"]];
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backgroundview.mas_left);
        make.top.equalTo(newpassword1.mas_bottom).offset(0);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, 1));
    }];
    
    UILabel *newPassword = [[UILabel alloc]init];
    newPassword.text = @"确认密码";
    [self.view addSubview:newPassword];
    [newPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(newpassword1.mas_left);
        make.top.equalTo(line2.mas_bottom).offset(0);
        make.size.mas_equalTo(CGSizeMake(70, 43));
    }];
    
    newPassWordTextfield2 = [[UITextField alloc]init];
    newPassWordTextfield2.placeholder = @"再次输入密码";
    newPassWordTextfield2.delegate = self;
    newPassWordTextfield2.secureTextEntry = YES;
    [newPassWordTextfield2 addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:newPassWordTextfield2];
    [newPassWordTextfield2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(newPassword.mas_right).offset(10);
        make.top.equalTo(newPassword.mas_top);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width-110, 43));
    }];
    
    UILabel *tipLabel = [[UILabel alloc]init];
    tipLabel.textColor = [UIColor grayColor];
    tipLabel.numberOfLines = 2;
    tipLabel.font = [UIFont systemFontOfSize:14];
    tipLabel.text = @"密码长度6~14个字符，可包含数字、字母及符号，不包含空格";
    [self.view addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.top.equalTo(backgroundview.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width-30, 44));
    }];
    
    okButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [okButton setTintColor:[UIColor whiteColor]];
    [okButton setTitle:@"确定" forState:UIControlStateNormal];
    okButton.layer.cornerRadius = 5;
    okButton.userInteractionEnabled = NO;
    okButton.backgroundColor = [UIColor colorWithRed:243/256.0 green:92/256.0 blue:90/256.0 alpha:0.5];
    [okButton addTarget:self action:@selector(changePassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:okButton];
    [okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(newpassword1.mas_left);
        make.top.equalTo(tipLabel.mas_bottom).offset(50);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width-30, 40));
    }];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    
}
-(void)valueChanged
{
    if ([newPassWordTextfield1.text isEqualToString:@""]||[newPassWordTextfield2.text isEqualToString:@""])
    {
        okButton.backgroundColor = [UIColor colorWithRed:243/256.0 green:92/256.0 blue:90/256.0 alpha:0.5];
        okButton.userInteractionEnabled = NO;
        
    }
    else
    {
        
        okButton.backgroundColor = [UIColor colorWithRed:243/256.0 green:92/256.0 blue:90/256.0 alpha:1];
        okButton.userInteractionEnabled = YES;
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [newPassWordTextfield1 resignFirstResponder];
    [newPassWordTextfield2 resignFirstResponder];
}
-(void)cancel
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)changePassword
{
    [newPassWordTextfield1 resignFirstResponder];
    [newPassWordTextfield2 resignFirstResponder];
    
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
        UserManager *manager = [UserManager sharedUserManager];
        [manager changeWithNewPassword:newPassWordTextfield1.text block:^(int result) {
            if (result == 1)//成功返回1
            {
                UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"修改成功！" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                [alertVc addAction:okAction];
                [self presentViewController:alertVc animated:YES completion:nil];
                
            }
            else //失败返回-1
            {
                UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"修改失败！" message:@"请检测网络后重试。" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alertVc addAction:okAction];
                [self presentViewController:alertVc animated:YES completion:nil];
            }
            
        }];

    }

}
-(NSInteger)getPassWordCorrectCode
{
    if (![newPassWordTextfield1.text isEqualToString:newPassWordTextfield2.text]) {
        return -1; //两次密码输入不一致；
    }
    else if (newPassWordTextfield1.text.length<6||newPassWordTextfield1.text.length>14||[self isHavingEmptyString:newPassWordTextfield1.text])
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)alertWithTitle:(NSString *)title massage:(NSString *)massage
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:title message:massage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVc addAction:okAction];
    [self presentViewController:alertVc animated:YES completion:nil];
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
