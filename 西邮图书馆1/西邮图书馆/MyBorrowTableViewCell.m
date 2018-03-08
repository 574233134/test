//
//  MyBorrowTableViewCell.m
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/2/10.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import "MyBorrowTableViewCell.h"
#import "UILabel+AutoFitWidth.h"
#import "Publicinfo.h"
#import <Masonry.h>
#import <AFHTTPSessionManager.h>
@implementation MyBorrowTableViewCell
{
    UILabel *department;
    UILabel *state;
    UILabel *date;
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}
-(void)initSubviews
{
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_titleLabel];
    
    department = [[UILabel alloc]init];
    department.font = [UIFont systemFontOfSize:13];
    department.text = @"所在分馆:";
    [self.contentView addSubview:department];
    
    _departmentLabel = [[UILabel alloc]init];
    _departmentLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_departmentLabel];
    
    state = [[UILabel alloc]init];
    state.font = [UIFont systemFontOfSize:13];
    state.text = @"当前状态:";
    [self.contentView addSubview:state];
    
    _stateLabel = [[UILabel alloc]init];
    _stateLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_stateLabel];
    
    date = [[UILabel alloc]init];
    date.font = [UIFont systemFontOfSize:13];
    date.text = @"到期时间:";
    [self.contentView addSubview:date];
    
    _dateLabel = [[UILabel alloc]init];
    _dateLabel.font = [UIFont systemFontOfSize:13];
    _dateLabel.textColor = [UIColor colorWithRed:243/256.0 green:92/256.0 blue:90/256.0 alpha:1];
    [self.contentView addSubview:_dateLabel];
    
    _renewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _renewButton.layer.cornerRadius = 5;
    _renewButton.layer.borderWidth = 0;
    _renewButton.backgroundColor = [UIColor colorWithRed:243/256.0 green:92/256.0 blue:90/256.0 alpha:1];
    _renewButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _renewButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_renewButton setTitle:@"续借" forState:UIControlStateNormal];
    [_renewButton addTarget:self action:@selector(reNewBook) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_renewButton];
    
    [department mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_left);
        make.top.equalTo(_titleLabel.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(60, 15));
    }];
    
    [_departmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(department.mas_right).offset(3);
        make.top.equalTo(department.mas_top);
        make.size.mas_equalTo(CGSizeMake(200, 15));
    }];
    [state mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(department.mas_left);
        make.top.equalTo(department.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(60, 15));
    }];
    [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(state.mas_right).offset(3);
        make.top.equalTo(state.mas_top);
        make.size.mas_equalTo(CGSizeMake(200, 15));
    }];
    [date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(state.mas_left);
        make.top.equalTo(state.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(60, 15));
    }];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(date.mas_right).offset(3);
        make.top.equalTo(date.mas_top);
        make.size.mas_equalTo(CGSizeMake(200, 15));
    }];
    [_renewButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_titleLabel.mas_right);
        make.top.equalTo(date.mas_top);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
}
-(void)reNewBook
{
    if([Publicinfo sharedPublicinfo].session == nil)
    {
        [Publicinfo updateSession:^(BOOL isSuccess) {
            if (isSuccess) {
                //续借
                [self loadReNewInfo];
            }
            else
            {
                //提示请检查网络
                [self alert:@"提示" massage:@"请检查网络"];
            }
        }];
    }
    //续借
    [self loadReNewInfo];
}
-(void)loadReNewInfo
{
    NSString *url = [NSString stringWithFormat:@"http://api.xiyoumobile.com/xiyoulibv2/user/renew?session=%@&barcode=%@&department_id=%@&library_id=%@",[Publicinfo sharedPublicinfo].session,self.barcode,self.departmentId,self.libraryId];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dic[@"Resault"] == 0)
        {
            [self alert:@"提示" massage:@"请检查网络"];
        }
        else
        {
            self.renewButton.userInteractionEnabled = NO;
            self.renewButton.backgroundColor =[UIColor colorWithRed:243/256.0 green:92/256.0 blue:90/256.0 alpha:0.5];
            [self.delegate reloadInfo:self.row];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self alert:@"错误" massage:@"续借失败,请重试！"];
    }];
}
-(void)alert:(NSString *)title massage:(NSString *)massage
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:massage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
    [alert addAction:action];
    [self.delegate present:alert];
}
-(void)setTitleText:(NSString *)text
{
    _titleLabel.text = text;
    _titleLabel.frame = CGRectMake(15, 10, [UIScreen mainScreen].bounds.size.width-30, [UILabel getHeightByWidth:[UIScreen mainScreen].bounds.size.width-30 title:text font:[UIFont systemFontOfSize:15]]);
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
