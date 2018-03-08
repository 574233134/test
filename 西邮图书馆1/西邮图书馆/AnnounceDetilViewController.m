//
//  AnnounceDetilViewController.m
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/1/16.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import "AnnounceDetilViewController.h"
#import "DetailModel.h"
#import "UILabel+AutoFitWidth.h"
#import "LodingView.h"
#import <Masonry.h>
#import <AFHTTPSessionManager.h>
#import <YYModel.h>
@interface DetilViewController ()

@end

@implementation DetilViewController
{
    DetailModel *detail;
    UILabel *publishLeft;
    UILabel *dateleft;
    LodingView *loadingview;
    FailedLoding *failedLoadview;
}
-(void)loadView
{
    [super loadView];
    [self loadSubview];
    [self network];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (_flag == 0) {
        self.title = @"公告详情";
    }
    else if(_flag == 1)
    {
        self.title = @"新闻详情";
    }
}
-(instancetype)init
{
    self = [super init];
    if (self) {
        _Id = [[NSString alloc]init];
        _baseurl = [[NSString alloc]init];
    }
    return self;
}
-(void)loadSubview
{

    self.view.backgroundColor = [UIColor whiteColor];
    self.webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-60)];
    self.webview.scrollView.backgroundColor = [UIColor whiteColor];
    self.webview.delegate = self;
    //self.webview.scrollView.bounces = NO;
    self.webview.scrollView.contentInset = UIEdgeInsetsMake(60, 0, 60, 0);
    [self.view addSubview:_webview];
    
   
    loadingview = [[LodingView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:loadingview];
    failedLoadview = [[FailedLoding alloc]initWithFrame:self.view.frame];
    failedLoadview.delagate = self;
    failedLoadview.hidden = YES;
    [self.view addSubview:failedLoadview];
    
    //添加webview头视图
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, -60, self.webview.frame.size.width, 60)];
    view.backgroundColor = [UIColor whiteColor];
    self.titleLable = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, view.frame.size.width-100, 60)];
    self.titleLable.numberOfLines = 2;
    self.titleLable.textAlignment = NSTextAlignmentCenter;
    [view addSubview:self.titleLable];
    [self.webview.scrollView addSubview:view];
    
    self.publisherLable = [[UILabel alloc]init];
    self.dateLable = [[UILabel alloc]init];
    
    publishLeft = [[UILabel alloc]init];
    publishLeft.frame = CGRectZero;
    publishLeft.text = @"发布单位：";
    dateleft = [[UILabel alloc]init];
    dateleft.frame = CGRectZero;
    dateleft.text = @"发布时间：";
    

}

-(void)network
{
    loadingview.hidden = NO;
    _baseurl = [_baseurl stringByAppendingString:_Id];
    AFHTTPSessionManager *sessionmanager = [AFHTTPSessionManager manager];
    sessionmanager.responseSerializer = [AFHTTPResponseSerializer serializer];
      [sessionmanager GET:_baseurl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *detialdic = [resultDic objectForKey:@"Detail"];
        detail = [DetailModel yy_modelWithDictionary:detialdic];
         [self.webview loadHTMLString:detail.Passage baseURL:[NSURL URLWithString:_baseurl]];
          self.titleLable.text = detail.Title;
          self.publisherLable.text = detail.Publisher;
          self.dateLable.text = detail.Date;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failedLoadview.hidden = NO;
    }];
    
   
}

//为Announcewebview添加观察者  监听其contentsize的变化 以便确定尾部视图的位置
-(void)addObserverForwebViewContentSize
{
    [self.webview.scrollView addObserver:self forKeyPath:@"contentSize" options:    NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}
//将Announcewebview上的观察者移除
-(void)removeObserverForWebViewContentSize
{
    [self.webview.scrollView removeObserver:self forKeyPath:@"contentSize"];
}
//观察者所监测的值发生改变时会调用次方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    [self LayoutfooterView];
}
-(void)LayoutfooterView
{
     //取消监听，因为这里会调整contentSize，避免无限递归
    [self removeObserverForWebViewContentSize];
    //将旧footerview移除
    UIView *oldFooterview = [self.view viewWithTag:1001];
    [oldFooterview removeFromSuperview];
    CGSize contentsize = self.webview.scrollView.contentSize;
    
    //添加新的footerview
    UIView *newFooterview = [[UIView alloc]init];
    newFooterview.frame = CGRectMake(0,contentsize.height, self.view.frame.size.width, 60);
    newFooterview.tag = 1001;
    [newFooterview addSubview:publishLeft];
    [newFooterview addSubview:self.publisherLable];
    [newFooterview addSubview:dateleft];
    [newFooterview addSubview:self.dateLable];
    float Publisherwidth = [UILabel getWidthWithTitle:self.publisherLable.text font:[UIFont systemFontOfSize:18]];
    float datewidth = [UILabel getWidthWithTitle:self.dateLable.text font:[UIFont systemFontOfSize:18]];
    [self.publisherLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(newFooterview.mas_right).offset(-30);
        make.top.equalTo(newFooterview.mas_top);
        make.size.mas_equalTo(CGSizeMake(Publisherwidth>datewidth?Publisherwidth:datewidth, 30));
    }];
    [self.dateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.publisherLable.mas_left);
        make.bottom.equalTo(newFooterview.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(datewidth, 30));
    }];
    [publishLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.publisherLable.mas_left);
        make.top.equalTo(self.publisherLable.mas_top);
        make.size.mas_equalTo(CGSizeMake(90, 30));
    }];
    [dateleft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.dateLable.mas_left);
        make.bottom.equalTo(self.dateLable.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(90, 30));
    }];
    [self.webview.scrollView addSubview:newFooterview];
    //重新监听
    [self addObserverForwebViewContentSize];
   
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
    [self addObserverForwebViewContentSize];
    loadingview.hidden = NO;

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
    [self removeObserverForWebViewContentSize];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
     loadingview.hidden = YES;

}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    failedLoadview.hidden = NO;
    loadingview.hidden = NO;
}

@end
