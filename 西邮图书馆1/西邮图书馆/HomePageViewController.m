//
//  HomePageViewController.m
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/1/13.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import "HomePageViewController.h"
#import "LMKTableViewCell.h"
#import"FailedLoding.h"
#import "LodingView.h"
#import "FailedLoding.h"
#import "SearchViewController.h"
#import "AnnounceDetilViewController.h"
#import "ListViewController.h"
#import <MJRefresh.h>
#import <YYModel.h>
#import "DataModel.h"
#import <AFHTTPSessionManager.h>
@interface HomePageViewController ()

@end

@implementation HomePageViewController
{
    float startContentOffsetX;
    float willEndContentOffsetX;
    float endContentOffsetX;
    NSUInteger totalPageaAnounce;
    NSUInteger totalPageNews;
    FailedLoding *failview;
    LodingView *loadingview;
    MJRefreshGifHeader *headerAnnounce ;
    MJRefreshAutoGifFooter *footerAnnounce;
    MJRefreshGifHeader *headerNews ;
    MJRefreshAutoGifFooter *footerNews;

}
@synthesize tableviewnews;
@synthesize tableviewannounce;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self network];
}
-(void)loadView
{
    [super loadView];
    [self loadSubviews];
    
}
-(instancetype)init
{
    self = [super init];
    if (self) {
        _NewsPage = 1;
        _AnnouncePage = 1;
        totalPageaAnounce =1;
        totalPageNews = 1;
        //公告数组初始化
        self.announcearray = [[NSMutableArray alloc]init];
        //新闻数组初始化
        self.newsarray = [[NSMutableArray alloc]init];
    }
    return self;
}
//加载子视图
-(void)loadSubviews
{
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"排行榜" style:UIBarButtonItemStylePlain target:self action:@selector(enterList)];
    
    UIBarButtonItem *rightbaritem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStylePlain target:self action:@selector(search)];
    self.navigationItem.rightBarButtonItem = rightbaritem;    //segment创建及设置
    _segment = [[LMKSegmentControl alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    [_segment setItems:[NSArray arrayWithObjects:@"公告信息",@"新闻信息" ,nil]];
    _segment.delagete = self;
    [self.view addSubview:_segment];
    
    
    
    //scrolView创建及属性设置
    _scrolView=[[UIScrollView alloc]initWithFrame:CGRectMake(0,40, self.view.frame.size.width,self.view.frame.size.height-40-64-49)];
    _scrolView.contentSize=CGSizeMake(self.view.frame.size.width*2,self.view.frame.size.height-40-49-64);
   
    _scrolView.delegate=self;
    _scrolView.pagingEnabled=YES;
    
    _scrolView.showsVerticalScrollIndicator=NO;
    _scrolView.bounces=NO;
    _scrolView.pagingEnabled = YES;
    [self.view addSubview:_scrolView];
    
     [self loadRefrshSubview];
    //公告tableview
    tableviewannounce =[[UITableView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, _scrolView.frame.size.height) style:UITableViewStyleGrouped];
    tableviewannounce.backgroundColor = [UIColor whiteColor];
    tableviewannounce.tag=201;
    tableviewannounce.delegate=self;
    tableviewannounce.dataSource=self;
    tableviewannounce.mj_header = headerAnnounce;
    tableviewannounce.mj_footer = footerAnnounce;
    [_scrolView addSubview:tableviewannounce];
    
    //新闻tableview
    tableviewnews=[[UITableView alloc]initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width,_scrolView.frame.size.height) style:UITableViewStyleGrouped];
    tableviewnews.backgroundColor = [UIColor whiteColor];
    tableviewnews.tag=202;
    tableviewnews.delegate=self;
    tableviewnews.dataSource=self;
    tableviewnews.mj_header = headerNews;
    tableviewnews.mj_footer = footerNews;
    [_scrolView addSubview:tableviewnews];
    
    
    failview = [[FailedLoding alloc]initWithFrame:_scrolView.frame];
    failview.hidden = YES;
    failview.delagate = self;
    [self.view addSubview:failview];
    loadingview = [[LodingView alloc]initWithFrame:_scrolView.frame];
    loadingview.hidden = NO;
    [self.view addSubview:loadingview];
   
}
-(void)enterList
{
    ListViewController *listVc = [[ListViewController alloc]init];
    listVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:listVc animated:YES];
}
-(void)search
{
    SearchViewController *searchVc = [[SearchViewController alloc]init];
    searchVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVc animated:YES];
}
-(void)loadRefrshSubview
{
    headerAnnounce = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [headerAnnounce setTitle:@"" forState:MJRefreshStateIdle];
    [headerAnnounce setTitle:@"释放立即刷新" forState:MJRefreshStatePulling];
    [headerAnnounce setTitle:@"刷新中..." forState:MJRefreshStateRefreshing];
    headerAnnounce.lastUpdatedTimeLabel.hidden = YES;
    headerAnnounce.stateLabel.font = [UIFont systemFontOfSize:15];
  
    footerAnnounce =  [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [footerAnnounce setTitle:@"" forState:MJRefreshStateIdle];
    [footerAnnounce setTitle:@"释放立即加载" forState:MJRefreshStatePulling];
    [footerAnnounce setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    [footerAnnounce setTitle:@"没有更多数据" forState:MJRefreshStateNoMoreData];
    
    headerNews = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [headerNews setTitle:@"" forState:MJRefreshStateIdle];
    [headerNews setTitle:@"释放立即刷新" forState:MJRefreshStatePulling];
    [headerNews setTitle:@"刷新中..." forState:MJRefreshStateRefreshing];
    headerNews.lastUpdatedTimeLabel.hidden = YES;
    headerNews.stateLabel.font = [UIFont systemFontOfSize:15];
    
    footerNews =  [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [footerNews setTitle:@"" forState:MJRefreshStateIdle];
    [footerNews setTitle:@"释放立即加载" forState:MJRefreshStatePulling];
    [footerNews setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    [footerNews setTitle:@"没有更多数据" forState:MJRefreshStateNoMoreData];
    
}
-(void)loadNewData
{
    
    
    if (_segment.selectIndex == 0) {
        [footerAnnounce resetNoMoreData];
        [_announcearray removeAllObjects];
        [self loadData:@"announce" andPage:1];
    }
    else if (_segment.selectIndex == 1)
    {
        [footerNews resetNoMoreData];
        [_newsarray removeAllObjects];
        [self loadData:@"news" andPage:1];
    }
  
    
}
-(void)loadMoreData

{
    if (_segment.selectIndex == 0) {
       
        if (_AnnouncePage < totalPageaAnounce) {
            [self loadData:@"announce" andPage:_AnnouncePage+1];
            [self.tableviewannounce.mj_footer setState:MJRefreshStateIdle];
        }
        else
        {
            [footerAnnounce endRefreshingWithNoMoreData];
        }

    }
    else if (_segment.selectIndex == 1)
    {
        if (_NewsPage < totalPageNews) {
            [self loadData:@"news" andPage:_NewsPage+1];
            [self.tableviewnews.mj_footer setState:MJRefreshStateIdle];
        }
        else
        {
            [footerNews endRefreshingWithNoMoreData];
        }

    }
    
    
}
//请求数据
-(void)loadData:(NSString *)type andPage:(NSUInteger)page
{
   
    NSString *baseurl = @"http://api.xiyoumobile.com/xiyoulibv2/news/getList/";
    baseurl=[[baseurl stringByAppendingString:type]stringByAppendingString:@"/"];
    NSString *pagestring = [NSString stringWithFormat:@"%lu",page];
    baseurl=[baseurl stringByAppendingString:pagestring];
    AFHTTPSessionManager *sessionmanager = [AFHTTPSessionManager manager];
    sessionmanager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [sessionmanager GET:baseurl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *resultdic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *dataarray =[[NSMutableArray alloc]init];
        NSInteger allPage = [[[resultdic objectForKey:@"Detail"]objectForKey:@"Pages"]intValue];
        NSInteger currentPage =[[[resultdic objectForKey:@"Detail"]objectForKey:@"CurrentPage"]intValue];
        dataarray = [[resultdic objectForKey:@"Detail"]objectForKey:@"Data"];
        for (int i=0; i<dataarray.count; i++)
        {
            DataModel *data = [DataModel yy_modelWithJSON:dataarray[i]];
            if ([type isEqualToString:@"announce"]) {
                [_announcearray addObject:data];
                [tableviewannounce.mj_header endRefreshing];
            }
            else if ([type isEqualToString:@"news"])
            {
                [_newsarray addObject:data];
                [tableviewnews.mj_header  endRefreshing];
                
            }
        }
        if ([type isEqualToString:@"announce"]) {
            totalPageaAnounce = allPage;
            _AnnouncePage = currentPage;
            [tableviewannounce reloadData];
            loadingview.hidden = YES;
            failview.hidden = YES;

        }
        else if ([type isEqualToString:@"news"])
        {
            totalPageNews = allPage;
            _NewsPage = currentPage;
            [tableviewnews reloadData];
            loadingview.hidden = YES;
            failview.hidden = YES;
            
        }
        
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failview.hidden = NO;
        loadingview.hidden=YES;
        
    }];
}
#pragma failedLoading delagate
//监听网络状态  当有网的时候调用请求数据的方法
-(void)network
{
        failview.hidden = YES;
        loadingview.hidden=NO;
        [self loadData:@"announce" andPage:1];
        [self loadData:@"news" andPage:1];
    
}

#pragma tableview DataSource
//设置每个section有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 201) {
        return _announcearray.count;
    }
    else if(tableView.tag == 202)
    {
        return _newsarray.count;
    }
    else
        return 0;
}
//为每个cell填充内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifier = @"cell";
    LMKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    
    if (cell == nil) {
        cell = [[LMKTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }

    if (tableView.tag == 201) {
        DataModel *announcedata = [_announcearray objectAtIndex:indexPath.row];
        NSString *tab = @"      ";
        NSString *str = [[announcedata.Title stringByAppendingString:tab]stringByAppendingString:announcedata.Date];
        cell.textlable.text = str;
        cell.textlable.font = [UIFont systemFontOfSize:15];
    }
    else if (tableView.tag == 202)
    {
        DataModel *newsdata = [_newsarray objectAtIndex:indexPath.row];
        NSString *tab = @"      ";
        NSString *str = [[newsdata.Title stringByAppendingString:tab]stringByAppendingString:newsdata.Date];
        cell.textlable.text = str;
        cell.textlable.font = [UIFont systemFontOfSize:15];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma tableview delagate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetilViewController *Detil =[[DetilViewController alloc]init];
    if(tableView.tag == 201)
    {
        DataModel *data = _announcearray[indexPath.row];
        Detil.Id = data.ID;
        Detil.baseurl =@"http://api.xiyoumobile.com/xiyoulibv2//news/getDetail/announce/html/";
        Detil.flag = 0;
    }
    else if (tableView.tag == 202)
    {
        DataModel *data = _newsarray[indexPath.row];
        Detil.Id = data.ID;
        Detil.baseurl =@"http://api.xiyoumobile.com/xiyoulibv2//news/getDetail/news/html/";
        Detil.flag =1;
    }
    [self.navigationController pushViewController:Detil animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0000001;
}

#pragma scollerview delagate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{    //拖动前的起始坐标
    if ([scrollView isMemberOfClass:[UIScrollView class]])
    {
        startContentOffsetX = scrollView.contentOffset.x;
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{    //将要停止前的坐标
    if ([scrollView isMemberOfClass:[UIScrollView class]])
    {
       willEndContentOffsetX = scrollView.contentOffset.x;
    }
}
//判断scrollerview是向左滑动还是向右划动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    endContentOffsetX = scrollView.contentOffset.x;
    if ([scrollView isMemberOfClass:[UIScrollView class]]) {
        if (endContentOffsetX < willEndContentOffsetX && willEndContentOffsetX < startContentOffsetX) { //画面从右往左移动，前一页
    
            [_segment setSelectIndex:_segment.selectIndex-1];
            
        } else if (endContentOffsetX > willEndContentOffsetX && willEndContentOffsetX > startContentOffsetX) {//画面从左往右移动，后一页
           
            [_segment setSelectIndex:_segment.selectIndex+1];
        }
    }
}
#pragma LMKSegmentcontrol Dalegate
//实现segmentcontrol的代理方法，改变scrollerview的位置
-(void)changePage:(NSUInteger)page
{
    if (page == 0) {
        [self.scrolView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
    else if(page == 1)
    {
        [self.scrolView setContentOffset:CGPointMake(self.view.frame.size.width, 0) animated:NO];
    }
}
@end
