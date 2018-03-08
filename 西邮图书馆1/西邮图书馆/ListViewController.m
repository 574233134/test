//
//  ListViewController.m
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/2/15.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import "ListViewController.h"
#import "LodingView.h"
#import "UILabel+AutoFitWidth.h"
#import "ListTableViewCell.h"
#import <AFNetworking.h>
@interface ListViewController ()

@end

@implementation ListViewController
{
    UITableView *tableview;
    UISegmentedControl *segmentcontrol;
    FailedLoding *failLoadView;
    LodingView *loadingView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)loadView
{
    [super loadView];
    [self loadSubviews];
    [self loadBorrowList];
}
-(instancetype)init
{
    self = [super init];
    if (self){
        _currentArray = [[NSMutableArray alloc]init];
        _searchArray = [[NSMutableArray alloc]init];
        _borrowArray = [[NSMutableArray alloc]init];
    }
    return self;
}
-(void)loadSubviews
{
    self.view.backgroundColor = [UIColor whiteColor];
    segmentcontrol =[[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"借阅排行",@"搜索排行", nil]] ;
    segmentcontrol.selectedSegmentIndex = 0;
    [segmentcontrol addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segmentcontrol;
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStyleGrouped];
    tableview.backgroundColor = [UIColor whiteColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.bounces = NO;
    [self.view addSubview:tableview];
    
    failLoadView = [[FailedLoding alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    failLoadView.delagate = self;
    failLoadView.hidden = YES;
    [self.view addSubview:failLoadView];
    
    loadingView = [[LodingView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    [self.view addSubview:loadingView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)valueChange:(UISegmentedControl *)seg
{
    if (seg.selectedSegmentIndex == 0) {
        _currentArray = _borrowArray;
    }
    else
    {
        _currentArray = _searchArray;
    }
    [tableview reloadData];
}
#pragma  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _currentArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[ListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if ([_currentArray[indexPath.row][@"Title"] isEqualToString:@" "]) {
        [cell setBookName:[NSString stringWithFormat:@"%lu. 暂无数据",indexPath.row+1]];
    }
    else
    {
        [cell setBookName:[NSString stringWithFormat:@"%lu. %@",indexPath.row+1,_currentArray[indexPath.row][@"Title"]]];
    }
    return cell;
}
#pragma UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [UILabel getHeightByWidth:self.view.frame.size.width-20 title:_currentArray[indexPath.row][@"Title"] font:[UIFont systemFontOfSize:15]]+20;
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
#pragma failLoading Delegate
-(void)network
{
    loadingView.hidden = NO;
    failLoadView.hidden = YES;
    [self loadBorrowList];
}
//----------------------------------加载数据部分------------------------------------
-(void)loadBorrowList
{
    loadingView.hidden = NO;
    NSString *url = [NSString stringWithFormat:@"http://api.xiyoumobile.com/xiyoulibv2/book/rank?type=%u&size=%u",1,25];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        _borrowArray = [dic objectForKey:@"Detail"];
        [self loadSearchList];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        loadingView.hidden = YES;
        failLoadView.hidden = NO;
    }];
}
-(void)loadSearchList
{
    NSString *url = [NSString stringWithFormat:@"http://api.xiyoumobile.com/xiyoulibv2/book/rank?type=%u&size=%u",2,25];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        _searchArray = [dic objectForKey:@"Detail"];
        if (segmentcontrol.selectedSegmentIndex == 0)
        {
            _currentArray = _borrowArray;
        }
        else
        {
            _currentArray = _searchArray;
        }
        [tableview reloadData];
        loadingView.hidden = YES;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        loadingView.hidden = YES;
        failLoadView.hidden = NO;
    }];

}

@end
