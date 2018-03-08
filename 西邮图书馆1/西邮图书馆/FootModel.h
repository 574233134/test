//
//  FootModel.h
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/2/2.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FootModel : NSObject
//"Title":"深入浅出Ext JS",  //书名
//"Barcode":"03455293",  //内部条形码
//"Type":"续借",  //操作类型，分为：借书、续借、还书
//"Date":"2014-06-23"  //操作日期

@property NSString *title;
@property NSString *barcode;
@property NSString *type;
@property NSString *date;

@end
