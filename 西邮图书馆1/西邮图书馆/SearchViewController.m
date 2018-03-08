//
//  SearchViewController.m
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/2/16.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import "SearchViewController.h"
#import "Publicinfo.h"
#import "NorecordView.h"
#import "NoMatchDataView.h"
#import "BookDescriptionViewController.h"
#import "SearchingView.h"
#import "NoSingleView.h"
#import "Publicinfo.h"
#import <AFNetworking.h>
@interface SearchViewController ()

@end

@implementation SearchViewController
{
    UISearchBar *searchbar;
    UITableView *searchTableview;
    NorecordView *norecordview;
    SearchingView *searchView;
    NoMatchDataView *nomatchdataView;
    NoSingleView *nosingleView;
    NSURLSessionDataTask *task;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
}
-(void)loadSubviews
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"搜索";
    
    searchbar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    searchbar.delegate = self;
    searchbar.placeholder = @"请输入书名/关键字";
   [self.view addSubview:searchbar];
    
    searchTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height-64-40) style:UITableViewStyleGrouped];
    searchTableview.delegate = self;
    searchTableview.dataSource =self;
    searchTableview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:searchTableview];
    
    norecordview = [[NorecordView alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height-64-40)];
    norecordview.hidden = YES;
    [self.view addSubview:norecordview];
    
    nomatchdataView = [[NoMatchDataView alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height-64-40)];
    nomatchdataView.hidden = YES;
    [self.view addSubview:nomatchdataView];
    
    searchView =[[SearchingView alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height-64-40)];
    searchView.hidden = YES;
    [self.view addSubview:searchView];
    
    nosingleView = [[NoSingleView alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height-64-40)];
    nosingleView.hidden = YES;
    [self.view addSubview:nosingleView];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [searchbar resignFirstResponder];
}
-(UIView *)createFooterView
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    footerView.backgroundColor = [UIColor whiteColor];
    
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [footerView addSubview:clearButton];
    clearButton.frame = CGRectMake((self.view.frame.size.width-80)/2.0, 7.5, 80, 25);
    [clearButton setTitle:@"清空历史" forState:UIControlStateNormal];
    [clearButton setTitle:@"清空历史" forState:UIControlStateHighlighted];
    [clearButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [clearButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    clearButton.layer.cornerRadius = 10;
    clearButton.layer.borderWidth = 1;
    clearButton.layer.borderColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1].CGColor;
    [clearButton addTarget:self action:@selector(clearHistory) forControlEvents:UIControlEventTouchUpInside];
    return footerView;
}

#pragma UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.text = _dataArray[indexPath.row][@"Title"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
};
//清除历史搜索记录
-(void)clearHistory
{
    [Publicinfo deleteAllSearchHistory];
    [searchTableview reloadData];
    norecordview.hidden = NO;
}
#pragma tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0000001;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [Publicinfo addSearchHistory:_dataArray[indexPath.row]];
    BookDescriptionViewController *introduction = [[BookDescriptionViewController alloc]initWithID:_dataArray[indexPath.row][@"ID"]];
    introduction.hidesBottomBarWhenPushed = YES;
    [searchbar resignFirstResponder];
    [self.navigationController pushViewController:introduction animated:YES];
    
}
-(void)displayHistory
{
    NSMutableArray *array = [Publicinfo getSearchHistory];
    if (array==nil||array.count == 0) {
        norecordview.hidden = NO;
    }
    else
    {
        norecordview.hidden = YES;
        _dataArray = array;
        searchTableview.tableFooterView = [self createFooterView];
        [searchTableview reloadData];
    }

}
#pragma searchbar delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    nosingleView.hidden = YES;
    nomatchdataView.hidden = YES;
    [self displayHistory];
    return YES;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    norecordview.hidden=YES;
    if (searchText==nil||[searchText isEqualToString:@""])
    {
        searchView.hidden = YES;
        [self displayHistory];
    }
    else
    {
        searchTableview.hidden = NO;
        searchTableview.tableFooterView = nil;
        [self loadSearchInfo:searchText];
    }
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}
-(void)loadSearchInfo:(NSString *)searchText
{
    searchView.hidden = NO;
    nomatchdataView.hidden = YES;
    nosingleView.hidden = YES;
    if (task)
    {
        [task cancel];
    }
    NSString *url = [NSString stringWithFormat:@"http://api.xiyoumobile.com/xiyoulibv2/book/search?keyword=%@&matchMethod=mh",searchText];
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPSessionManager *sessionmanger = [AFHTTPSessionManager manager];
    sessionmanger.responseSerializer = [AFHTTPResponseSerializer serializer];
    task=[sessionmanger GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([dic[@"Detail"] isKindOfClass:[NSString class]])
        {
            searchView.hidden = YES;
            nomatchdataView.hidden = NO;
        }
        else
        {
            _dataArray = dic[@"Detail"][@"BookData"];
            [searchTableview reloadData];
            searchView.hidden = YES;
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
          {
              searchView.hidden = YES;
              nosingleView.hidden = NO;
          }];
}
@end
