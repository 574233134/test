//
//  MyCollectionViewController.m
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/2/6.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "MyCollectionCell.h"
#import "Publicinfo.h"
#import "LodingView.h"
#import "NorecordView.h"
#import "CollectionModel.h"
#import <AFNetworking.h>
#import <YYModel.h>
#import <UIImageView+WebCache.h>
@interface MyCollectionViewController ()

@end

@implementation MyCollectionViewController
{
    UITableView *tableview;
    NorecordView *norecordView;
    LodingView *loadingView;
    FailedLoding *failLoadView;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return self;
}
-(void)loadSubview
{
    self.title = @"我的收藏";
    self.view.backgroundColor = [UIColor whiteColor];
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStyleGrouped];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.bounces = NO;
    tableview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tableview];
    
    failLoadView = [[FailedLoding alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    failLoadView.delagate = self;
    [self.view addSubview:failLoadView];
    norecordView = [[NorecordView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    [self.view addSubview:norecordView];
    loadingView = [[LodingView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    [self.view addSubview:loadingView];
 
}
-(void)loadView
{
    [super loadView];
    [self loadSubview];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadCollection];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    MyCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
       cell = [[MyCollectionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CollectionModel *model = [[CollectionModel alloc]init];
    model = _dataArray[indexPath.row];
    cell.titleLabel.text = model.title;
    cell.publisherLabel.text = model.publisher;
    cell.authorLabel.text = model.author;
    cell.indexLabel.text = model.sort;
    cell.Id = model.Id;
    cell.delegate = self;
    cell.row = indexPath.row;
    if ([model.images isEqual:[NSNull null]])
    {
        cell.bookImage.image = [UIImage imageNamed:@"占位图片"];
    }
    else
    {
        //判断网络状态是否是蜂窝数据
        if ([Publicinfo sharedPublicinfo].networkState == AFNetworkReachabilityStatusReachableViaWWAN) {
            //判断显示图片的开关是否打开
            if ([Publicinfo getShowPic] == YES) {
                [cell.bookImage sd_setImageWithURL:[model.images objectForKey:@"large"] placeholderImage:[UIImage imageNamed:@"占位图片"]];
            }
            else
            {
                cell.bookImage.image = [UIImage imageNamed:@"占位图片"];
            }
        }
        else
        {

            [cell.bookImage sd_setImageWithURL:[model.images objectForKey:@"large"] placeholderImage:[UIImage imageNamed:@"占位图片"]];
        }
    }

    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma tableview delagate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}
-(void)loadCollection
{
    loadingView.hidden = NO;
    norecordView.hidden = YES;
    failLoadView.hidden = YES;
    NSString *session = [Publicinfo sharedPublicinfo].session;
    if(session == nil)
    {
        [Publicinfo updateSession:^(BOOL isSuccess) {
            if (isSuccess)
            {
                [self collectionInfo];
            }
            else
            {
                loadingView.hidden = YES;
                failLoadView.hidden = NO;
            }
        }];
    }
    else
    {
        [self collectionInfo];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

#pragma 加载收藏信息
-(void)collectionInfo
{
    NSString *session = [Publicinfo sharedPublicinfo].session;
    NSString *baseUrl =  [NSString stringWithFormat:@"http://api.xiyoumobile.com/xiyoulibv2/user/favoriteWithImg?session=%@",session];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:baseUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSString *resultString = [dic objectForKey:@"Result"];
        NSInteger resultcode = [resultString integerValue];
        if (resultcode == 1)
        {
            if ([dic[@"Detail"] isKindOfClass:[NSString class]])
            {
                loadingView.hidden = YES;
                norecordView.hidden = NO;
            }
            else
            {
                NSArray *collection = [dic objectForKey:@"Detail"];
                for (int i =0; i<collection.count; i++)
                {
                    CollectionModel *model = [[CollectionModel alloc]init];
                    model = [CollectionModel yy_modelWithJSON:collection[i]];
                    [_dataArray addObject:model];
                }
                [tableview reloadData];
                loadingView.hidden = YES;
                norecordView.hidden = YES;
                failLoadView.hidden = YES;
            }
        }
        else
        {
            loadingView.hidden = YES;
            failLoadView.hidden=NO;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        loadingView.hidden = YES;
        norecordView.hidden = YES;
        failLoadView.hidden=NO;
    }];
}
#pragma failLoading delegate
-(void)network
{
    [self loadCollection];
}
#pragma mycollectioncell delegate
-(void)reLoadInfo:(NSInteger)row
{
    [self.dataArray removeObjectAtIndex:row];
    if (_dataArray.count == 0) {
        loadingView.hidden = YES;
        norecordView.hidden = NO;
        failLoadView.hidden=YES;
    }
    else
    {
        [tableview reloadData];
    }
}
-(void)present:(UIAlertController *)alertVc
{
    UIAlertController *vc = alertVc;
    [self presentViewController: vc animated:YES completion:^{}];
}
@end
