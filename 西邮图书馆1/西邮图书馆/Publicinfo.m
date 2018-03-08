//
//  Publicinfo.m
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/1/21.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import "Publicinfo.h"
#import <SSKeychain.h>
#import <AFNetworking.h>
@implementation Publicinfo
//全局实例变量
static Publicinfo *publicinfo = nil;
static SSKeychain *keychain;
+(instancetype)sharedPublicinfo
{
    @synchronized (self) {
        if (publicinfo == nil) {
            publicinfo = [[self alloc]init];
        }
    }
    return publicinfo;
}
+(void)setCurrentAccount:(NSString *)username
{
    NSUserDefaults *userdefult = [NSUserDefaults standardUserDefaults];
    [userdefult setObject:username forKey:@"currentAccount"];
}
+(NSString *)getCurrentAccount
{
    NSUserDefaults *userdefult = [NSUserDefaults standardUserDefaults];
    return [userdefult objectForKey:@"currentAccount"];
}
+(void)removeCurrentAccount
{
    NSUserDefaults *userdefult = [NSUserDefaults standardUserDefaults];
    [userdefult removeObjectForKey:@"currentAccount"];
}


+(void)setMyData:(NSDictionary *)dic
{
    NSUserDefaults *usedefult = [NSUserDefaults standardUserDefaults];
    [usedefult setObject:dic forKey:@"userInfoDic"];
}
+(NSDictionary *)getMyData
{
    NSUserDefaults *usedefult = [NSUserDefaults standardUserDefaults];
    return [usedefult objectForKey:@"userInfoDic"];
}
+(void)deleteMyData
{
    NSUserDefaults *usedefult = [NSUserDefaults standardUserDefaults];
    [usedefult removeObjectForKey:@"userInfoDic"];
}


+(void)setShowPic:(BOOL)isOn
{
    NSUserDefaults *userdefult = [NSUserDefaults standardUserDefaults];
    [userdefult setBool:isOn forKey:@"showPicSwitchValue"];
}
+(BOOL)getShowPic
{
    NSUserDefaults *userdefult = [NSUserDefaults standardUserDefaults];
    return [userdefult boolForKey:@"showPicSwitchValue"];
}

+(void)setExpirationTip:(BOOL)isOn
{
    NSUserDefaults *userdefult = [NSUserDefaults standardUserDefaults];
    [userdefult setBool:isOn forKey:@"ExpirationTipSwitchValue"];
}
+(BOOL)getExpirationTip
{
    NSUserDefaults *userdefult = [NSUserDefaults standardUserDefaults];
    return [userdefult boolForKey:@"ExpirationTipSwitchValue"];
}
//添加和删除以及查看搜索记录
+(void)addSearchHistory:(NSDictionary *)dataDic
{
    NSMutableArray *mutableArray =[NSMutableArray arrayWithArray:[Publicinfo getSearchHistory]];
    [mutableArray addObject:dataDic];
    NSOrderedSet *orderset = [NSOrderedSet orderedSetWithArray:mutableArray];
    mutableArray = [NSMutableArray arrayWithArray:[orderset array]];
    NSUserDefaults *userdefult = [NSUserDefaults standardUserDefaults];
    [userdefult setObject:mutableArray forKey:@"SearchHistory"];
}
+(void)deleteAllSearchHistory
{
    NSUserDefaults *userdefult = [NSUserDefaults standardUserDefaults];
    [userdefult removeObjectForKey:@"SearchHistory"];
}
+(NSMutableArray *)getSearchHistory
{
    NSUserDefaults *userdefult = [NSUserDefaults standardUserDefaults];
    return [userdefult objectForKey:@"SearchHistory"];
}
+(NSString *)getUsername;
{
  NSArray *array= [SSKeychain allAccounts] ;
   return  [array[0] objectForKey:@"acct"];
}
+(NSString *)getPassword
{
    NSString *account = [Publicinfo getUsername];
    return [SSKeychain passwordForService:@"西邮图书馆" account:account];
}

+(void)saveUserName:(NSString *) userName password:(NSString *) password
{
    //登录时需要设置当前用户
    [Publicinfo setCurrentAccount:userName];
    [SSKeychain deletePasswordForService: @"西邮图书馆" account:userName];
    [SSKeychain setPassword:password forService:@"西邮图书馆" account:userName];
}
+(void)deleteUserNameAndPassword
{
    NSString *account = [Publicinfo getUsername];
    [Publicinfo removeCurrentAccount];
    [Publicinfo deleteMyData];
    [Publicinfo deleteAllSearchHistory];
    [SSKeychain deletePasswordForService:@"西邮图书馆" account:account];
}

//更新session
+(void)updateSession:(void(^)(BOOL isSuccess)) result
{
    NSString *username = [Publicinfo getUsername];
    NSString *password = [Publicinfo getPassword];
    NSString *baseurl = [NSString stringWithFormat:@"http://api.xiyoumobile.com/xiyoulibv2/user/login?username=S%@&password=%@",username,password];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:baseurl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *resultdic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSString *string = [[resultdic objectForKey:@"Detail"]stringByReplacingOccurrencesOfString:@" " withString:@""];
        [Publicinfo sharedPublicinfo].session = string;
        result(YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        result(NO);
    }];
}
@end
