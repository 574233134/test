//
//  ChangeViewController.m
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/1/23.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import "ChangeViewController.h"
#import "Publicinfo.h"
#import <Masonry.h>
#import <AFNetworking.h>
@interface ChangeViewController ()

@end

@implementation ChangeViewController
{
    UILabel *currentLabel;
    UILabel *newLabel;
    UILabel *renewLabel;
    UITextField *currentTextfield;
    UITextField *newTextfield;
    UITextField *renewTextfield;
    UIButton *loginChange;
    UIView *loginView;
}
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
    self.title = @"修改密码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    currentLabel = [[UILabel alloc]init];
    currentLabel.text = @"当前密码";
    [self.view addSubview:currentLabel];
    
    currentTextfield = [[UITextField alloc]init];
    currentTextfield.placeholder = @"输入当前密码";
    currentTextfield.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    currentTextfield.secureTextEntry = YES;
    currentTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    currentTextfield.font = [UIFont systemFontOfSize:15];
    currentTextfield.layer.cornerRadius = 5;
    currentTextfield.delegate = self;
    [currentTextfield addTarget:self action:@selector(valueChange) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:currentTextfield];
    
    newLabel = [[UILabel alloc]init];
    newLabel.text = @"新  密  码";
    [self.view addSubview:newLabel];
    
    newTextfield = [[UITextField alloc]init];
    newTextfield.placeholder = @"输入新密码";
    newTextfield.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    newTextfield.secureTextEntry = YES;
    newTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    newTextfield.font = [UIFont systemFontOfSize:15];
    newTextfield.layer.cornerRadius = 5;
    newTextfield.delegate = self;
    [newTextfield addTarget:self action:@selector(valueChange) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:newTextfield];
    
    renewLabel = [[UILabel alloc]init];
    renewLabel.text = @"确认密码";
    [self.view addSubview:renewLabel];
    
    renewTextfield = [[UITextField alloc]init];
    renewTextfield.placeholder = @"确认新密码";
    renewTextfield.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    renewTextfield.secureTextEntry = YES;
    renewTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    renewTextfield.font = [UIFont systemFontOfSize:15];
    renewTextfield.layer.cornerRadius = 5;
    renewTextfield.delegate = self;
    [renewTextfield addTarget:self action:@selector(valueChange) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:renewTextfield];
    
    loginChange = [UIButton buttonWithType:UIButtonTypeSystem];
    [loginChange setTitle:@"提交修改" forState:UIControlStateNormal];
    loginChange.backgroundColor =[UIColor colorWithRed:243/256.0 green:92/256.0 blue:90/256.0 alpha:0.5];
    loginChange.layer.cornerRadius = 5;
    loginChange.userInteractionEnabled = NO;
    [loginChange setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginChange addTarget:self action:@selector(loginChange) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginChange];
    
    
    loginView = [[UIView alloc]init];
    loginView.hidden = YES;
    [self.view addSubview:loginView];
    UILabel *lable = [[UILabel alloc]init];
    lable.text = @"提交中...";
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = [UIFont systemFontOfSize:15];
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activity startAnimating];
    [loginView addSubview:lable];
    [loginView addSubview:activity];
    
    [currentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.top.equalTo(self.view.mas_top).offset(30);
        make.size.mas_equalTo(CGSizeMake(70, 30));
    }];
    
    [currentTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(currentLabel.mas_right).offset(5);
        make.top.equalTo(currentLabel.mas_top);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.bottom.equalTo(currentLabel.mas_bottom);
    }];
    [newLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(currentLabel.mas_left);
        make.top.equalTo(currentLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(70, 30));
    }];
    [newTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(newLabel.mas_right).offset(5);
        make.right.equalTo(currentTextfield.mas_right);
        make.top.equalTo(currentTextfield.mas_bottom).offset(10);
        make.height.mas_equalTo(newLabel.mas_height);
    }];
    [renewLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(currentLabel.mas_left);
        make.top.equalTo(newLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(70, 30));
    }];
    [renewTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(renewLabel.mas_right).offset(5);
        make.right.equalTo(newTextfield.mas_right);
        make.top.equalTo(newTextfield.mas_bottom).offset(10);
        make.height.mas_equalTo(renewLabel.mas_height);
    }];
    [loginChange mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.top.equalTo(renewLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(@40);
    }];
    [loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(loginChange.mas_bottom);
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
-(void)valueChange
{
    if ([currentTextfield.text isEqualToString:@""]||[newTextfield.text isEqualToString:@""]||[renewTextfield.text isEqualToString:@""]) {
        loginChange.backgroundColor = [UIColor colorWithRed:243/256.0 green:92/256.0 blue:90/256.0 alpha:0.5];
        loginChange.userInteractionEnabled = NO;
    }
    else
    {
        loginChange.backgroundColor = [UIColor colorWithRed:243/256.0 green:92/256.0 blue:90/256.0 alpha:1];
        loginChange.userInteractionEnabled = YES;
    }
}
-(void)loginChange
{
    [currentTextfield resignFirstResponder];
    [newTextfield resignFirstResponder];
    [renewTextfield resignFirstResponder];
    loginView.hidden = NO;
    [self loginData];
}
-(void)loginData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *session = [Publicinfo sharedPublicinfo].session;
    NSString *username =[Publicinfo getUsername];
    if (![newTextfield.text isEqualToString:renewTextfield.text]) {
        loginView.hidden = YES;
        [self loadAlert:@"提示" massage:@"新旧密码输入不一致"];
    }
    else
    {
        NSString *baseurl = [NSString stringWithFormat:@"http://api.xiyoumobile.com/xiyoulibv2/user/modifyPassword?session=%@&username=S%@&password=%@&newpassword=%@&repassword=%@",session,username,currentTextfield.text,newTextfield.text,renewTextfield.text];
        [manager POST:baseurl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil ];
            if ([(NSString *)resultDic[@"Detail"] isEqualToString:@"MODIFY_SUCCEED"]) {
                //提示 密码修改成功
                loginView.hidden = YES;
                [Publicinfo saveUserName:[Publicinfo getUsername] password:newTextfield.text];
                [Publicinfo removeCurrentAccount];
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码修改成功" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:^{}];
                
            }
            else if ([(NSString *)resultDic[@"Detail"] isEqualToString:@"INVALID_PASSWORD"])
            {
                if([[Publicinfo getPassword] isEqualToString:currentTextfield.text])
                {
                    //更新session后重新请求
                    [Publicinfo updateSession:^(BOOL isSuccess) {
                        if (isSuccess) {
                            
                            [self loginData];
                        }
                        else
                        {
                            [self loadAlert:@"提交失败" massage:@"请检查网络"];
                        }
                    }];
                }
                else
                {
                    //提示 当前密码输入错误
                    [self loadAlert:@"提示" massage:@"当前密码输入错误"];
                }
            }
            else
            {
                //错误  请重试
                [self loadAlert:@"错误" massage:@"请重试"];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //提交失败  请检查网络
            loginView.hidden = YES;
            [self loadAlert:@"提交失败" massage:@"请检查网络"];
        }];
    }

}
-(void)loadAlert:(NSString *)title massage:(NSString *)massage
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:massage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:^{}];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [currentTextfield resignFirstResponder];
    [newTextfield resignFirstResponder];
    [renewTextfield resignFirstResponder];
}
#pragma textfield delagate
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;
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
