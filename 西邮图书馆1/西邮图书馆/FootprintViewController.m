//
//  FootprintViewController.m
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/2/2.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import "FootprintViewController.h"
#import "FootModel.h"
#import "LodingView.h"
#import "NorecordView.h"
#import "Publicinfo.h"
#import "UILabel+AutoFitWidth.h"
#import "HistoryTableViewCell.h"
#import <Masonry.h>
#import <AFNetworking.h>
#import <YYModel.h>
@interface FootprintViewController ()

@end

@implementation FootprintViewController
{
    UITableView *footTableView;
    NSMutableArray *dataArray;
    LodingView *loadview;
    NorecordView *norecoreview;
    FailedLoding *failedLodingView;
}
-(void)loadView
{
    [super loadView];
    [self loadSubviews];
   
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    loadview.hidden = NO;
    [self loadInfo];
}
-(void)loadSubviews
{
    self.title = @"我的足迹";
    footTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height-64) style:UITableViewStylePlain];
    footTableView.bounces = NO;
    footTableView.dataSource = self;
    footTableView.delegate = self;
    footTableView.estimatedRowHeight = 120;
    footTableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:footTableView];
    
    failedLodingView = [[FailedLoding alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    failedLodingView.delagate = self;
    [self.view addSubview:failedLodingView];
    norecoreview = [[NorecordView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    [self.view addSubview:norecoreview];
    loadview = [[LodingView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    [self.view addSubview:loadview];
    
    dataArray = [[NSMutableArray alloc]init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)loadInfo
{
    NSString *session = [Publicinfo sharedPublicinfo].session;
    if (session == nil) {
        [Publicinfo updateSession:^(BOOL isSuccess) {
            if (isSuccess) {
                [self loaddata];
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
        [self loaddata];
    }
}
-(void)loaddata
{
    NSString *url = [NSString stringWithFormat:@"http://api.xiyoumobile.com/xiyoulibv2/user/history?session=%@",[Publicinfo sharedPublicinfo].session];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([[resultDic objectForKey:@"Detail"] isKindOfClass:[NSString class]])
        {
            loadview.hidden = YES;
            norecoreview.hidden = NO;
            failedLodingView.hidden = YES;
        }
        else
        {
            
            NSArray *footdic = [resultDic objectForKey:@"Detail"];
            for (int i =0; i<footdic.count; i++) {
                FootModel *model = [[FootModel alloc]init];
                model = [FootModel yy_modelWithJSON:footdic[i]];
                [dataArray addObject:model];
            }
            [footTableView reloadData];
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
#pragma tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[HistoryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    FootModel *model = dataArray[indexPath.row];
    [cell setTitleText:model.title];
    cell.typeLabel.text = model.type;
    cell.dateLabel.text = model.date;
    return cell;
}

#pragma tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FootModel *model = dataArray[indexPath.row];
    CGFloat height = [UILabel getHeightByWidth:[UIScreen mainScreen].bounds.size.width-30 title:model.title font:[UIFont systemFontOfSize:15]];
    return height+65;
}
#pragma faildloadingview delagate
-(void)network
{
    failedLodingView.hidden = YES;
    norecoreview.hidden = YES;
    loadview.hidden = NO;
    [self loadInfo];
}
@end
