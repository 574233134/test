//
//  BookDescriptionViewController.m
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/2/11.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import "BookDescriptionViewController.h"
#import "UILabel+AutoFitWidth.h"
#import "BookDetailViewController.h"
#import "Publicinfo.h"
#import "LodingView.h"
#import <YYModel.h>
#import <Masonry.h>
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
@interface BookDescriptionViewController ()
{
    UIView *backView;
    UIImageView *backBook;
    UIImageView *bookImage;
    LodingView *loadingView;
    FailedLoding *failedLoadingView;
}
@end

@implementation BookDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(instancetype)initWithbarcode:(NSString *)barcode
{
    self=[super init];
    if (self) {
        self.barcode = barcode;
    }
    return self;
}
-(instancetype)initWithID:(NSString *)ID
{
    self=[super init];
    if (self) {
        self.ID = ID;
    }
    return self;
 
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadView
{
    [super loadView];
    [self loadSubview];
    if (_ID==nil) {
        [self loadIntrodutionInfoWithBarcode];
    }
    else
        [self loadIntrodutionInfoWithID];
   
}
-(void)loadSubview
{
    self.title = @"图书简介";
    self.view.backgroundColor = [UIColor colorWithRed:243/256.0 green:92/256.0 blue:90/256.0 alpha:1];
    
    
    backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 7;
    [self.view addSubview:backView];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = [UIFont systemFontOfSize:15];
    [backView addSubview:_titleLabel];
    
    _authorLabel = [[UILabel alloc]init];
    _authorLabel.textColor = [UIColor colorWithWhite:0.6 alpha:1];
    _authorLabel.font = [UIFont systemFontOfSize:13];
    [backView addSubview:_authorLabel];
    
    backBook = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"书籍背景"]];
    [backView addSubview:backBook];
    bookImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"占位图片"]];
    bookImage.contentMode = UIViewContentModeScaleAspectFit;
    bookImage.backgroundColor = [UIColor whiteColor];
    [backBook addSubview:bookImage];
    
    _introductionLabel = [[UILabel alloc]init];
    _introductionLabel.numberOfLines = 0;
    _introductionLabel.font = [UIFont systemFontOfSize:13];
    _introductionLabel.textColor = [UIColor colorWithWhite:0.6 alpha:1];
    [backView addSubview:_introductionLabel];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.top.equalTo(self.view.mas_top).offset(30);
        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
        make.right.equalTo(self.view.mas_right).offset(-15);
    }];
   
    [_authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_left);
        make.top.equalTo(_titleLabel.mas_bottom).offset(5);
        make.right.equalTo(_titleLabel.mas_right);
        make.height.equalTo(@15);
    }];
    [backBook mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_left);
        make.right.equalTo(backView.mas_right);
        make.top.equalTo(_authorLabel.mas_bottom).offset(5);
        make.height.equalTo(@150);
    }];
    [bookImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backBook.mas_centerX);
        make.top.equalTo(backBook.mas_top).offset(5);
        make.bottom.equalTo(backBook.mas_bottom).offset(-5);
        make.width.equalTo(@100);
    }];
    [_introductionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_left);
        make.right.equalTo(_titleLabel.mas_right);
        make.top.equalTo(backBook.mas_bottom).offset(30);
        make.bottom.equalTo(backView.mas_bottom).offset(-20);
    }];
    
    loadingView =[[LodingView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    [self.view addSubview:loadingView];
    
    failedLoadingView = [[FailedLoding alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    failedLoadingView.delagate = self;
    failedLoadingView.hidden = YES;
    [self.view addSubview:failedLoadingView];
}
-(void)setTitleText:(NSString *)title
{
    _titleLabel.text = title;
    _titleLabel.frame = CGRectMake(10, 5, backView.frame.size.width-20, [UILabel getHeightByWidth:backView.frame.size.width-20 title:title font:[UIFont systemFontOfSize:15]]);
}
-(void)loadIntrodutionInfoWithBarcode
{
    loadingView.hidden = NO;
    failedLoadingView.hidden = YES;
    NSString *url = [NSString stringWithFormat:@"http://api.xiyoumobile.com/xiyoulibv2/book/detail/barcode/%@",self.barcode];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        _dataDic = dic[@"Detail"];
        [self loadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        loadingView.hidden = YES;
        failedLoadingView.hidden = NO;
    }];
}
-(void)loadIntrodutionInfoWithID
{
    loadingView.hidden = NO;
    failedLoadingView.hidden = YES;
    NSString *url = [NSString stringWithFormat:@"http://api.xiyoumobile.com/xiyoulibv2/book/detail/id/%@",self.ID];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        _dataDic = dic[@"Detail"];
        [self loadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        loadingView.hidden = YES;
        failedLoadingView.hidden = NO;
    }];

}
-(void)loadData
{
    loadingView.hidden = NO;
    failedLoadingView.hidden = YES;
    [self setTitleText:_dataDic[@"Title"]];
    NSString *authorText = _dataDic[@"Author"];
    authorText=[authorText stringByReplacingOccurrencesOfString:@"4" withString:@""];
    _authorLabel.text = authorText;
    NSString *introduction =_dataDic[@"Summary"];
    if ([introduction isEqualToString:@""])
    {
        if ([_dataDic[@"DoubanInfo"] isEqual:[NSNull null]])
        {
            _introductionLabel.text = @"暂无数据";
        }
        else
        {
            if ([_dataDic[@"DoubanInfo"][@"Summary"] isEqualToString:@""])
            {
                _introductionLabel.text = @"暂无数据";
            }
            else
            {
                _introductionLabel.text = _dataDic[@"DoubanInfo"][@"Summary"];
            }
        }
    }
    else
    {
        _introductionLabel.text = introduction;
    }

    if ([_dataDic[@"DoubanInfo"] isEqual:[NSNull null]])
    {
        bookImage.image = [UIImage imageNamed:@"占位图片"];
    }
    else
    {
        //判断网络状态是否是蜂窝数据
        if ([Publicinfo sharedPublicinfo].networkState == AFNetworkReachabilityStatusReachableViaWWAN) {
            //判断显示图片的开关是否打开
            if ([Publicinfo getShowPic] == YES) {
                [bookImage sd_setImageWithURL:_dataDic[@"DoubanInfo"][@"Images"][@"large"] placeholderImage:[UIImage imageNamed:@"占位图片"]];
            }
            else
            {
               bookImage.image = [UIImage imageNamed:@"占位图片"];
            }
        }
        else
        {
            
            [bookImage sd_setImageWithURL:_dataDic[@"DoubanInfo"][@"Images"][@"large"] placeholderImage:[UIImage imageNamed:@"占位图片"]];
        }
    }
    loadingView.hidden = YES;
    failedLoadingView.hidden = YES;
}
#pragma failedloadingview delegate
-(void)network
{
    if (_ID==nil) {
        [self loadIntrodutionInfoWithBarcode];
    }
    else
        [self loadIntrodutionInfoWithID];
}
//点击事件
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    BookDetailViewController *bookdetail = [[BookDetailViewController alloc]initWithDictionary:_dataDic];
    bookdetail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:bookdetail animated:YES];
}

@end
