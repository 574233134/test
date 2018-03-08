//
//  MyBorrowViewController.m
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/2/7.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import "MyBorrowViewController.h"
#import "MyBorrowModel.h"
#import "UILabel+AutoFitWidth.h"
#import "Publicinfo.h"
#import "LodingView.h"
#import "NorecordView.h"
#import "BookDescriptionViewController.h"
#import <Masonry.h>
#import <AFHTTPSessionManager.h>
#import <YYModel.h>
@interface MyBorrowViewController ()

@end

@implementation MyBorrowViewController
{
    UITableView *tableview;
    FailedLoding *failedLodingView;
    LodingView *loadview;
    NorecordView *norecoreview;
    UILabel *haveBorrow;
    UILabel *noBorrow;
    UILabel *renew;
    UILabel *overLine;
}
-(instancetype)init
{
    self = [super init];
    if (self) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return self;
}
-(void)loadView
{
    [super loadView];
    [self loadSubviews];
    [self loadSession];
}
-(void)loadSubviews
{
    self.title = @"我的借阅";
    self.view.backgroundColor = [UIColor whiteColor];
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStyleGrouped];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.bounces = NO;
    tableview.backgroundColor = [UIColor whiteColor];
    tableview.tableHeaderView = [self loadHeaderView];
    tableview.bounces = NO;
    [self.view addSubview:tableview];
    
    failedLodingView = [[FailedLoding alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    failedLodingView.delagate = self;
    [self.view addSubview:failedLodingView];
    norecoreview = [[NorecordView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    [self.view addSubview:norecoreview];
    loadview = [[LodingView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    [self.view addSubview:loadview];
}
-(void)loadSession
{
    NSString *session = [Publicinfo sharedPublicinfo].session;
    if (session == nil)
    {
        [Publicinfo updateSession:^(BOOL isSuccess){
            if (isSuccess)
            {
                [self loadMyBorrowInfo];
            }
            else
            {
                loadview.hidden = YES;
                norecoreview.hidden = YES;
                failedLodingView.hidden = NO;
            }
        }];
        
    }
    else
    {
        [self loadMyBorrowInfo];
    }
}
-(UIView *)loadHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 25)];
    headerView.backgroundColor =[UIColor colorWithWhite:0.7 alpha:1];
    CGFloat width = (headerView.frame.size.width-30)/4;
    
    haveBorrow = [[UILabel alloc]init];
    [haveBorrow setTextColor:[UIColor greenColor]];;
    [headerView addSubview:haveBorrow];
    noBorrow = [[UILabel alloc]init];
    noBorrow.textColor = [UIColor yellowColor];
    [headerView addSubview:noBorrow];
    renew = [[UILabel alloc]init];
    renew.textAlignment = NSTextAlignmentRight;
    renew.textColor = [UIColor orangeColor];
    [headerView addSubview:renew];
    overLine = [[UILabel alloc]init];
    overLine.textColor = [UIColor colorWithRed:243/256.0 green:92/256.0 blue:90/256.0 alpha:1];
    overLine.textAlignment = NSTextAlignmentRight;
    [headerView addSubview:overLine];
    
    [haveBorrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView.mas_left).offset(15);
        make.top.equalTo(headerView.mas_top);
        make.size.mas_equalTo(CGSizeMake(width, 25));
    }];
    [noBorrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(haveBorrow.mas_right);
        make.top.equalTo(haveBorrow.mas_top);
        make.size.mas_equalTo(CGSizeMake(width, 25));
    }];
    [renew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(noBorrow.mas_right);
        make.top.equalTo(haveBorrow.mas_top);
        make.size.mas_equalTo(CGSizeMake(width, 25));
    }];
    [overLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(renew.mas_right);
        make.top.equalTo(haveBorrow.mas_top);
        make.size.mas_equalTo(CGSizeMake(width, 25));
    }];
    return headerView;
}

-(void)reloadData
{
    
    NSInteger reNewCount = 0,overLineCount=0;
    for (int i=0; i<_dataArray.count; i++)
    {
        MyBorrowModel *model = _dataArray[i];
        if (model.canRenew ==0)
        {
            reNewCount++;
        }
        if ([model.state isEqualToString:@"本馆超期"])
        {
            overLineCount++;
        }
    }
    haveBorrow.text = [NSString stringWithFormat:@"已借：%lu",_dataArray.count];
    noBorrow.text = [NSString stringWithFormat:@"可借：%lu",15-_dataArray.count];
    renew.text = [NSString stringWithFormat:@"续借：%lu",reNewCount];
    overLine.text = [NSString stringWithFormat:@"超期：%lu",overLineCount];
    [tableview reloadData];
}

-(void)loadMyBorrowInfo
{
    NSString *url = [NSString stringWithFormat:@"http://api.xiyoumobile.com/xiyoulibv2/user/rent?session=%@",[Publicinfo sharedPublicinfo].session];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([dic[@"Detail"] isKindOfClass:[NSString class]])
        {
            if ([dic[@"Detail"] isEqualToString:@"NO_RECORD"])
            {
                loadview.hidden = YES;
                norecoreview.hidden = NO;
                failedLodingView.hidden = YES;            }
            else if ([dic[@"Detail"] isEqualToString:@"SESSION_INVALID"])
            {
                [self loadSession];
            }
        }
        else
        {
            NSArray *array = [dic objectForKey:@"Detail"];
            for (int i=0; i<array.count; i++)
            {
                MyBorrowModel *model = [MyBorrowModel yy_modelWithDictionary:array[i]];
                [_dataArray addObject:model];
            }
            [self reloadData];
            loadview.hidden = YES;
            norecoreview.hidden = YES;
            failedLodingView.hidden = YES;
           
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        loadview.hidden = YES;
        norecoreview.hidden = YES;
        failedLodingView.hidden = NO;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma tableview Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    MyBorrowTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[MyBorrowTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MyBorrowModel *model = _dataArray[indexPath.row];
    [cell setTitleText:model.title];
    cell.departmentLabel.text = model.department;
    cell.stateLabel.text = model.state;
    NSMutableString *date = [NSMutableString stringWithFormat:@"%@",model.date];
    [date insertString:@"-" atIndex:4];
    [date insertString:@"-" atIndex:7];
    cell.dateLabel.text = date;
    cell.canRenew = model.canRenew;
    cell.barcode = model.barcode;
    cell.departmentId = model.departmentId;
    cell.libraryId = model.libraryId;
    cell.row = indexPath.row;
    cell.delegate = self;
    if(cell.canRenew == 0)
    {
        cell.renewButton.userInteractionEnabled = NO;
        cell.renewButton.backgroundColor = [UIColor colorWithRed:243/256.0 green:92/256.0 blue:90/256.0 alpha:0.5];

    }
    return cell;
}
#pragma tableview delagate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyBorrowModel *model = _dataArray[indexPath.row];
    CGFloat height = [UILabel getHeightByWidth:[UIScreen mainScreen].bounds.size.width-30 title:model.title font:[UIFont systemFontOfSize:15]];
    return height+80;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyBorrowModel *model = _dataArray[indexPath.row];
    BookDescriptionViewController *bookDescriptionVc = [[BookDescriptionViewController alloc]initWithbarcode:model.barcode];
    [self.navigationController pushViewController:bookDescriptionVc animated:YES];
}

#pragma faildloadingview delegate
-(void)network
{
    loadview.hidden = NO;
    norecoreview.hidden = YES;
    failedLodingView.hidden = YES;
    [self loadSession];
}
#pragma MyBorrowTableViewCellDelegate
-(void)present:(UIAlertController *)alert
{
    [self presentViewController:alert animated:YES completion:^{}];
}
-(void)reloadInfo:(NSInteger)row
{
    MyBorrowModel *model = _dataArray[row];
    model.canRenew = false;
    model.state = @"本馆续借";
    [_dataArray replaceObjectAtIndex:row withObject:model];
    [self reloadData];
}
@end
