//
//  BookDetailViewController.m
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/2/12.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import "BookDetailViewController.h"
#import <Masonry.h>
#import "UILabel+AutoFitWidth.h"
#import "Publicinfo.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>
#define viewWidth self.view.frame.size.width
#define viewHeight self.view.frame.size.height
@interface BookDetailViewController ()

@end

@implementation BookDetailViewController
{
    UIImageView *backview;
    UILabel *titleLabel;
    UIView *oneview;
    UIView *twoview;
    UIView *threeView;
    UIView *fourView;
    UIScrollView *scrollView;
    CGFloat scollorHeight;
}
-(void)loadView
{
    [super loadView];
    self.title = @"图书详情";
    self.view.backgroundColor = [UIColor whiteColor];
     [self loadScrollView];
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        _dataDic = dictionary;
    }
    return self;
}
-(void)loadScrollView
{
    scrollView = [[UIScrollView alloc]init];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    scrollView.frame = CGRectMake(0, 0,viewWidth,viewHeight-64);
    [self loadBookImageViewAndTitle];
    [self loadBasicInfo];
    [self loadCirculationInfo];
    [self loadSubject];
    [self loadReferBooks];
    scrollView.contentSize = CGSizeMake(viewWidth, scollorHeight);
}
-(void)loadBookImageViewAndTitle
{
    backview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"书籍背景"]];
    [scrollView addSubview:backview];
    backview.frame = CGRectMake(0, 0, viewWidth, 150);
    UIImageView *bookImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"占位图片"]];
    bookImageView.contentMode = UIViewContentModeScaleAspectFit;
    bookImageView.backgroundColor = [UIColor whiteColor];
    [backview addSubview:bookImageView];
    [bookImageView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(backview.mas_top).offset(5);
        make.bottom.equalTo(backview.mas_bottom).offset(-5);
        make.width.mas_equalTo(100);
    }];
    if ([_dataDic[@"DoubanInfo"] isEqual:[NSNull null]])
    {
        bookImageView.image = [UIImage imageNamed:@"占位图片"];
    }
    else
    {
        if ([Publicinfo sharedPublicinfo].networkState == AFNetworkReachabilityStatusReachableViaWWAN)
        {
            
            if ([Publicinfo getShowPic] == YES)
            {
                [bookImageView sd_setImageWithURL:_dataDic[@"DoubanInfo"][@"Images"][@"large"] placeholderImage:[UIImage imageNamed:@"占位图片"]];
            }
            else
            {
                bookImageView.image = [UIImage imageNamed:@"占位图片"];
            }
        }
        else
        {
            
            [bookImageView sd_setImageWithURL:_dataDic[@"DoubanInfo"][@"Images"][@"large"] placeholderImage:[UIImage imageNamed:@"占位图片"]];
        }
    }

    titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.text = _dataDic[@"Title"];
    titleLabel.numberOfLines = 0;
    [scrollView addSubview:titleLabel];
    titleLabel.frame = CGRectMake(10, backview.frame.size.height+5, viewWidth, [UILabel getHeightByWidth:viewWidth-20 title:_dataDic[@"Title"] font:[UIFont systemFontOfSize:15]]);
    scollorHeight = backview.frame.size.height+5+titleLabel.frame.size.height;
}

-(void)loadBasicInfo//1、基本资料
{
    CGFloat height=10;
    oneview = [[UIView alloc]init];
    [scrollView addSubview:oneview];
    UIImageView *oneImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1"]];
    [oneview addSubview:oneImageView];
    oneImageView.frame = CGRectMake(10, 10, 29, 29);
    height = height+29;
    UILabel *oneLabel = [[UILabel alloc]init];
    oneLabel.text = @"基本资料";
    oneLabel.font = [UIFont systemFontOfSize:15];
    [oneview addSubview:oneLabel];
    oneLabel.frame = CGRectMake(49, 24, 80, 15);
    
    UIImageView *collectionImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"收藏"]];
    [oneview addSubview:collectionImage];
    collectionImage.frame = CGRectMake(viewWidth/2, 10, 29, 29);
   
    UIButton *collectionButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    collectionButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [collectionButton addTarget:self action:@selector(addCollection) forControlEvents:UIControlEventTouchUpInside];
    [collectionButton setTitle:@"收藏" forState:UIControlStateNormal];
    [oneview addSubview:collectionButton];
    collectionButton.frame = CGRectMake(viewWidth/2+39, 24, 40, 15);
   
    height+=10;
    UILabel *sortLabel = [[UILabel alloc]init];
    sortLabel.font = [UIFont systemFontOfSize:13];
    sortLabel.text = [NSString stringWithFormat:@"索书号：%@",_dataDic[@"Sort"]];
    sortLabel.frame = CGRectMake(10, height, 300, 15);
    height+=25;
    [oneview addSubview:sortLabel];
    
    UILabel *authorLabel = [[UILabel alloc]init];
    authorLabel.font = [UIFont systemFontOfSize:13];
    NSString *authortext = _dataDic[@"Author"];
    authortext = [authortext stringByReplacingOccurrencesOfString:@"4" withString:@""];
    authorLabel.text = [NSString stringWithFormat:@"作者：%@",authortext];
    authorLabel.frame = CGRectMake(10, height, 300, 15);
    [oneview addSubview:authorLabel];
    height+=25;
    
    UILabel *publishLabel = [[UILabel alloc]init];
    publishLabel.font = [UIFont systemFontOfSize:13];
    publishLabel.text = [NSString stringWithFormat:@"出版：%@",_dataDic[@"Pub"]];
    [oneview addSubview:publishLabel];
    publishLabel.frame = CGRectMake(10, height, 300, 15);
    height+=25;
    
    UILabel *renttimesLabel = [[UILabel alloc]init];
    renttimesLabel.font = [UIFont systemFontOfSize:13];
    renttimesLabel.text = [NSString stringWithFormat:@"借阅次数：%@",_dataDic[@"RentTimes"]];
    [oneview addSubview:renttimesLabel];
    renttimesLabel.frame = CGRectMake(10, height, 300, 15);
    height+=25;
    
    UILabel *collcttimesLabel = [[UILabel alloc]init];
    collcttimesLabel.font = [UIFont systemFontOfSize:13];
    collcttimesLabel.text = [NSString stringWithFormat:@"收藏次数：%@",_dataDic[@"FavTimes"]];
    [oneview addSubview:collcttimesLabel];
    collcttimesLabel.frame = CGRectMake(10, height, 300, 15);
    height+=25;
    
    oneview.frame = CGRectMake(0,scollorHeight , viewWidth, height);
    scollorHeight += height;
 
}
-(void)loadCirculationInfo//2、流通情况
{
    CGFloat height = 10;
    twoview = [[UIView alloc]init];
    [scrollView addSubview:twoview];
    UIImageView *twoImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"2"]];
    [twoview addSubview:twoImageView];
    twoImageView.frame = CGRectMake(10, height, 29, 29);
    height+=29;
    
    UILabel *twoLabel = [[UILabel alloc]init];
    twoLabel.font = [UIFont systemFontOfSize:15];
    twoLabel.text = @"流通情况";
    [twoview addSubview:twoLabel];
    twoLabel.frame = CGRectMake(49, 24, 80, 15);
    height+=10;
    
    UILabel *tipLabel = [[UILabel alloc]init];
    tipLabel.font = [UIFont systemFontOfSize:13];
    tipLabel.text = @"图书流通情况如下：";
    [twoview addSubview:tipLabel];
    tipLabel.frame = CGRectMake(10, height, 140, 15);
    height+=25;
    
    UILabel *avaliableLabel = [[UILabel alloc]init];
    avaliableLabel.font = [UIFont systemFontOfSize:13];
    avaliableLabel.text = [NSString stringWithFormat:@"可借图书：%@",_dataDic[@"Avaliable"]];
    [twoview addSubview:avaliableLabel];
    avaliableLabel.frame = CGRectMake(10, height, 100, 15);
   
    
    UILabel *totalLabel = [[UILabel alloc]init];
    totalLabel.font = [UIFont systemFontOfSize:13];
    totalLabel.text = [NSString stringWithFormat:@"共有图书：%@",_dataDic[@"Total"]];
    [twoview addSubview:totalLabel];
    totalLabel.frame = CGRectMake(viewWidth/2, height, 100, 15);
     height+=25;
   
    NSArray *circulationInfoArray = _dataDic[@"CirculationInfo"];
    for (int i=0; i<circulationInfoArray.count; i++)
    {
        CGFloat tempHeight=10;
        UIView *infoBackView = [[UIView alloc]init];
        infoBackView.layer.cornerRadius = 5;
        infoBackView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
        infoBackView.frame = CGRectMake(10, height, viewWidth-20, 85);
        [twoview addSubview:infoBackView];
        height += 95;
        
        UILabel *barcodeLabel = [[UILabel alloc]init];
        barcodeLabel.font = [UIFont systemFontOfSize:13];
        barcodeLabel.text = [NSString stringWithFormat:@"条码：%@",[circulationInfoArray[i] objectForKey:@"Barcode"]];
        [infoBackView addSubview:barcodeLabel];
        barcodeLabel.frame = CGRectMake(10, tempHeight, 120, 15);
        tempHeight += 25;
        
        UILabel *statusLabel = [[UILabel alloc]init];
        statusLabel.font = [UIFont systemFontOfSize:13];
        statusLabel.text = [NSString stringWithFormat:@"状态：%@",[circulationInfoArray[i] objectForKey:@"Status"]];
        statusLabel.frame = CGRectMake(10, tempHeight, 120, 15);
        [infoBackView addSubview:statusLabel];
        tempHeight+= 25;
        
        UILabel *departmentLabel = [[UILabel alloc]init];
        departmentLabel.font = [UIFont systemFontOfSize:13];
        departmentLabel.text = [NSString stringWithFormat:@"所在书库：%@",[circulationInfoArray[i] objectForKey:@"Department"]];
        departmentLabel.frame = CGRectMake(10, tempHeight, 280, 15);
        [infoBackView addSubview:departmentLabel];
        tempHeight+=25;
    }
    twoview.frame = CGRectMake(0, scollorHeight, viewWidth, height);
    scollorHeight += height;
}
-(void)loadSubject//3、图书主题
{
    CGFloat height = 10;
    threeView = [[UIView alloc]init];
    [scrollView addSubview:threeView];
    UIImageView *twoImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"3"]];
    [threeView addSubview:twoImageView];
    twoImageView.frame = CGRectMake(10, height, 29, 29);
    height+=29;
    
    UILabel *twoLabel = [[UILabel alloc]init];
    twoLabel.font = [UIFont systemFontOfSize:15];
    twoLabel.text = @"图书主题";
    [threeView addSubview:twoLabel];
    twoLabel.frame = CGRectMake(49, 24, 80, 15);
    height+=10;
    
    UILabel *subjectLabel = [[UILabel alloc]init];
    subjectLabel.text = _dataDic[@"Subject"];
    subjectLabel.font = [UIFont systemFontOfSize:13];
    subjectLabel.frame = CGRectMake(10, height, viewWidth-20, 15);
    [threeView addSubview:subjectLabel];
    height+=25;
    
    threeView.frame = CGRectMake(0, scollorHeight, viewWidth, height);
    scollorHeight+=height;

}
-(void)loadReferBooks //4、相关推荐
{
    CGFloat height = 10;
    fourView = [[UIView alloc]init];
    [scrollView addSubview:fourView];
    UIImageView *twoImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"4"]];
    [fourView addSubview:twoImageView];
    twoImageView.frame = CGRectMake(10, height, 29, 29);
    height+=29;
    
    UILabel *twoLabel = [[UILabel alloc]init];
    twoLabel.font = [UIFont systemFontOfSize:15];
    twoLabel.text = @"相关推荐";
    [fourView addSubview:twoLabel];
    twoLabel.frame = CGRectMake(49, 24, 80, 15);
    height+=10;
    
    NSArray *referBooksArray = _dataDic[@"ReferBooks"];
    for (int i=0; i<referBooksArray.count; i++)
    {
        CGFloat tempHeight=10;
        UIView *infoBackView = [[UIView alloc]init];
        infoBackView.layer.cornerRadius = 5;
        infoBackView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
        infoBackView.frame = CGRectMake(10, height, viewWidth-20, 85);
        [fourView addSubview:infoBackView];
        height += 95;
        
        UILabel *TitleLabel = [[UILabel alloc]init];
        TitleLabel.font = [UIFont systemFontOfSize:13];
        TitleLabel.text = [NSString stringWithFormat:@"书名：%@",[referBooksArray[i] objectForKey:@"Title"]];
        [infoBackView addSubview:TitleLabel];
        TitleLabel.frame = CGRectMake(10, tempHeight, viewWidth-40, 15);
        tempHeight += 25;
        
        UILabel *AuthorLabel = [[UILabel alloc]init];
        AuthorLabel.font = [UIFont systemFontOfSize:13];
        AuthorLabel.text = [NSString stringWithFormat:@"作者：%@",[referBooksArray[i] objectForKey:@"Author"]];
        AuthorLabel.frame = CGRectMake(10, tempHeight,viewWidth-40 , 15);
        [infoBackView addSubview:AuthorLabel];
        tempHeight+= 25;
        
        UILabel *IDLabel = [[UILabel alloc]init];
        IDLabel.font = [UIFont systemFontOfSize:13];
        IDLabel.text = [NSString stringWithFormat:@"索引号：%@",[referBooksArray[i] objectForKey:@"ID"]];
        IDLabel.frame = CGRectMake(10, tempHeight, viewWidth-40, 15);
        [infoBackView addSubview:IDLabel];
        tempHeight+=25;
    }
    fourView.frame = CGRectMake(0, scollorHeight, viewWidth, height);
    scollorHeight+=height;
}
-(void)addCollection
{
    if ([Publicinfo getCurrentAccount] == nil || [(NSString *)[Publicinfo getCurrentAccount] isEqualToString:@""])
    {
        //提示用户进行登录
        [self alert:@"未登录!" massage:@"请先登录"];
    }
    else
    {
    NSString *url = [NSString stringWithFormat:@"http://api.xiyoumobile.com/xiyoulibv2/user/addFav?session=%@&id=%@",[Publicinfo sharedPublicinfo].session,_dataDic[@"ID"]];
    AFHTTPSessionManager *manger =[AFHTTPSessionManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manger POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([dic[@"Detail"] isEqualToString:@"ADDED_SUCCEED"])
        {
            //添加成功
            [self alert:@"添加成功" massage:nil];
        }
        else if ([dic[@"Detail"] isEqualToString:@"ALREADY_IN_FAVORITE"])
        {
            //您已收藏 请勿重复操作
            [self alert:@"已收藏" massage:@"请勿重复操作"];
        }
        else if ([dic[@"Detail"] isEqualToString:@"USER_NOT_LOGIN"])
        {
            [Publicinfo updateSession:^(BOOL isSuccess){
                if (isSuccess)
                {
                    [self addCollection];
                }
                else
                {
                    //操作失败 请检查网络
                    [self alert:@"操作失败" massage:@"请检查网络"];
                }
            }];
        }
         else
         {
             [self alert:@"收藏失败" massage:@"请重试！"];
         }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //操作失败  请检查网络
        [self alert:@"操作失败" massage:@"请检查网络"];
    }];
    }
}
-(void)alert:(NSString *)title massage:(NSString *)massage
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:massage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
