//
//  MyCollectionCell.m
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/2/6.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import "MyCollectionCell.h"
#import "Publicinfo.h"
#import <AFNetworking.h>
#import <Masonry.h>
@implementation MyCollectionCell
{
    UILabel *author;
    UILabel *publisher;
    UILabel *index;
    UIButton *cancelButton;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self loadImage];
        [self loadLabel];
        [self loadButton];
    }
    return self;
}
-(void)loadImage
{
    _bookImage = [[UIImageView alloc]init];
    [self.contentView addSubview:_bookImage];
    [_bookImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.width.equalTo(@100);
    }];
    _bookImage.contentMode = UIViewContentModeScaleAspectFit;
    _bookImage.backgroundColor = [UIColor whiteColor];
}
-(void)loadLabel
{
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_titleLabel];
    
    author = [[UILabel alloc]init];
    author.text = @"作者";
    author.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:author];
    _authorLabel = [[UILabel alloc]init];
    _authorLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_authorLabel];
    
    publisher = [[UILabel alloc]init];
    publisher.text = @"出版";
    publisher.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:publisher];
    _publisherLabel = [[UILabel alloc]init];
    _publisherLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_publisherLabel];
    
    index = [[UILabel alloc]init];
    index.text = @"索书号";
    index.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:index];
    _indexLabel = [[UILabel alloc]init];
    _indexLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_indexLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bookImage.mas_right).offset(10);
        make.top.equalTo(self.bookImage.mas_top);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.height.equalTo(@65);
    }];
    [author mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(30, 15));
    }];
    [_authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(author.mas_right);
        make.top.equalTo(author.mas_top);
        make.size.mas_equalTo(CGSizeMake(80, 15));
    }];
    [publisher mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(author.mas_left);
        make.top.equalTo(author.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(30, 15));
    }];
    [_publisherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(publisher.mas_right);
        make.top.equalTo(publisher.mas_top);
        make.size.mas_equalTo(CGSizeMake(100, 15));
    }];
    [index mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo (publisher.mas_left);
        make.top.equalTo(publisher.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(40, 15));
    }];
    [_indexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(index.mas_right);
        make.top.equalTo(index.mas_top);
        make.size.mas_equalTo(CGSizeMake(80, 15));
    }];
    
}
-(void)loadButton
{
    cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [cancelButton setTitle:@"取消收藏" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(loadAlert) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:cancelButton];
    
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.top.mas_equalTo(index.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
}
//取消收藏
-(void)cancelCollection
{
    NSString *session = [Publicinfo sharedPublicinfo].session;
    NSString *url = [NSString stringWithFormat:@"http://api.xiyoumobile.com/xiyoulibv2/user/delFav?session=%@&id=%@&username=S%@",session,_Id,[Publicinfo getUsername]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSString *result = [dictionary objectForKey:@"Detail"];

                if ([result isEqualToString:@"DELETED_SUCCEED"])
                {
                    [self.delegate reLoadInfo:_row];
                }
                else if ([result isEqualToString:@"USER_NOT_LOGIN"])
                {
                    [Publicinfo updateSession:^(BOOL isSuccess)
                     {
                         if (isSuccess)
                         {
                             [self cancelCollection];
                         }
                         else
                         {  //失败，请检查网络
                             [self alert:@"失败" massage:@"请检查网络"];
                         }
                     }];
                    
                }
                else
                {
                    //错误  请重试
                    [self alert:@"错误" massage:@"请重试"];
                }
        
            }
 
    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self alert:@"失败" massage:@"请检查网络"];
    }];
}
-(void)loadAlert
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定取消该收藏" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self cancelCollection];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [self.delegate present:alert];
}
-(void)alert:(NSString *)title massage:(NSString *)massage
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:massage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
    [alert addAction:action];
    [self.delegate present:alert];
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
