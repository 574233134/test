//
//  FeedBackViewController.m
//  教学辅助平台-教师端
//
//  Created by 李梦珂 on 2018/2/10.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "FeedBackViewController.h"
#import "CustomTableViewCell.h"
#import "UITextView+Placeholder.h"
#import "UserManager.h"
#import <Masonry.h>
@interface FeedBackViewController ()

@end

@implementation FeedBackViewController
{
    UITableView *fbtableview;
    NSArray *feedtypeArray;
    NSMutableArray *indexPatharray;
    UITextField *contactfield;
    UITextView *detilTextview;
    NSString *fbType;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)loadView
{
    [super loadView];
    [self loadSubview];
}
-(void)loadSubview
{
    self.view.backgroundColor = [UIColor whiteColor];
    feedtypeArray = [[NSArray alloc]initWithObjects:@"功能异常：故障或不可用",@"产品建议：我有更好的建议",@"其他问题", nil];
    indexPatharray = [NSMutableArray array];
    fbtableview = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    fbtableview.delegate = self;
    fbtableview.dataSource = self;
    fbtableview.bounces = NO;
    [self.view addSubview:fbtableview];
    
    contactfield = [[UITextField alloc]init];
    contactfield.delegate = self;
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary]; // 创建属性字典
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:14]; // 设置font
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor]; // 设置颜色
    NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:@"手机号/QQ/邮箱" attributes:attrs]; // 初始化富文本占位字符串
   contactfield.attributedPlaceholder = attStr;
    
    
    detilTextview = [[UITextView alloc]init];
    detilTextview.font = [UIFont systemFontOfSize:14];
    detilTextview.delegate = self;
    [detilTextview setPlaceholder:@"请输入详细的问题或建议..." placeholdColor:[UIColor colorWithRed:128/256.0 green:128/256.0 blue:128/256.0 alpha:0.7]];
    
    UIBarButtonItem *submitButton = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submit)];
    self.navigationItem.rightBarButtonItem = submitButton;

}
-(void)submit
{
    int i=0;
    for (; i<indexPatharray.count; i++)
    {
        CustomTableViewCell *mycell = [fbtableview cellForRowAtIndexPath:indexPatharray[i]];
        if (mycell.select_ima.isHighlighted)
        {
            fbType = feedtypeArray[i];
            break;
        }
    }
    if (detilTextview.text == nil||[detilTextview.text isEqualToString:@""])
    {
        [self alertWithTitle:@"提示" massage:@"请您对问题进行详细描述！"];
    }
    else if (contactfield.text == nil || [contactfield.text isEqualToString:@""])
    {
        [self alertWithTitle:@"提示" massage:@"您还未输入联系方式！"];
    }
    else
    {
        [self feedBack];
    }
    

}
-(void)feedBack
{
    UserManager *manger = [UserManager sharedUserManager];
    [manger updateUserInfoFromBackgroundWithblock:^(int result)
    {
        if (result)
        {
            BmobObject *userObject = manger.userInfo;
            [manger saveSuggestionToBackgroundWith:[userObject objectForKey:@"username"] type:fbType description:detilTextview.text contact:contactfield.text block:^(int result) {
                if (result)
                {
                    [self alertWithTitle:@"提交成功！" massage:nil];
                }
                else
                {
                    [self alertWithTitle:@"提交失败" massage:@"请检查网络后重试！"];
                }
            }];
        }
        else
        {
             [self alertWithTitle:@"提交失败" massage:@"请检查网络后重试！"];
        }
    }];
}
-(void)alertWithTitle:(NSString *)title massage:(NSString *)massage
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:title message:massage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVc addAction:okAction];
    [self presentViewController:alertVc animated:YES completion:nil];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [detilTextview resignFirstResponder];
    [contactfield resignFirstResponder];
}
#pragma textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma textview delegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"])
    {
        
        [textView resignFirstResponder];
        
        return NO;
        
    }
    
    return YES;
    
}
#pragma tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return feedtypeArray.count;
    }
    else
    {
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        CustomTableViewCell *cell = [[CustomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        [indexPatharray addObject:indexPath];
        cell.feedbackType.text = feedtypeArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(indexPath.row == 0)
        {
            [cell.select_ima setHighlighted:YES];
            _selIndex = indexPath;
        }
        return cell;
    }
    else
    {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section == 1)
        {
            [cell.contentView addSubview:detilTextview];
            [detilTextview mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView.mas_left).offset(10);
                make.right.equalTo(cell.contentView.mas_right).offset(-10);
                make.height.mas_equalTo(@100);
            }];
        }
        else if(indexPath.section == 2)
        {
            [cell.contentView addSubview:contactfield];
            [contactfield mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView.mas_left).offset(15);
                make.right.equalTo(cell.contentView.mas_right).offset(-15);
                make.centerX.equalTo(cell.contentView.mas_centerX);
                make.height.mas_equalTo(@44);
            }];
        }
        return cell;
    }
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title;
    if (section == 0)
    {
        title = @"反馈类型";
        
    }
    else if(section == 1)
    {
        
        title = @"详细描述";
        
    }
    else
    {
        title = @"联系方式";
    }
    return title;

}
#pragma tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        return 100;
    }
    else
    {
        return 44;
    }
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    
//    UIView *headerView = [[UIView alloc]init];
//    
//    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    
//    UILabel *label = [[UILabel alloc]init];
//    
//    label.textColor = [UIColor grayColor];
//    
//    label.font = [UIFont systemFontOfSize:13];
//    
//    label.frame = CGRectMake(15, 0, 100, 20);
//    
//    [headerView addSubview:label];
//    if (section == 0)
//    {
//        
//        label.text = @"反馈类型";
//        
//    }
//    else if(section == 1)
//    {
//        
//        label.text = @"详细描述";
//        
//    }
//    else
//    {
//        label.text = @"联系方式";
//    }
//    
//    return headerView;
//    
//}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0000001;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        CustomTableViewCell *celld = [tableView cellForRowAtIndexPath:_selIndex];
        [celld.select_ima setHighlighted:NO];
        _selIndex = indexPath;
        CustomTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell.select_ima setHighlighted:YES];
    }

}

@end
