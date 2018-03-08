//
//  Publicinfo.h
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/1/21.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Publicinfo : NSObject

@property (nonatomic) NSString *session;
@property NSInteger networkState;

+(instancetype)sharedPublicinfo;
+(NSString *)getCurrentAccount;//获取当前用户
+(void)removeCurrentAccount;//删除当前用户
+(NSString *)getUsername;//获取用户名
+(NSString *)getPassword;//获取密码

+(void)setMyData:(NSDictionary *)dic;
+(NSDictionary *)getMyData;

//保存用户名和密码
+(void)saveUserName:(NSString *) userName password:(NSString *) password;
//删除用户名和密码，删除currentAcount 以及钥匙串中保存的值
+(void)deleteUserNameAndPassword;

//更新session
+(void)updateSession:(void(^)(BOOL isSuccess)) result;

//保存2G/3G/4G下显示图片开关的值
+(void)setShowPic:(BOOL)isOn;
+(BOOL)getShowPic;
//存取到期提示开关值
+(void)setExpirationTip:(BOOL)isOn;
+(BOOL)getExpirationTip;


//添加和删除以及查看搜索记录
+(void)addSearchHistory:(NSDictionary *)dataDic;
+(void)deleteAllSearchHistory;
+(NSMutableArray *)getSearchHistory;
@end
