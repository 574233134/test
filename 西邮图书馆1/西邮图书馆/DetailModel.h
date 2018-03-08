//
//  DetailModel.h
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/1/16.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailModel : NSObject
//"Title":"图书馆召开2014年度电子文献资源议标（询价）会",  //标题
//"Publisher":"图书馆",  //发布者
//"Date":"2014-6-25",  //发布日期
//"Passage":"<p><font>&#x3000;&#x3000;&#x4E3A;&#x4E86;&#x4E……"  //正文
@property NSString *Title;
@property NSString *Publisher;
@property NSString *Date;
@property NSString *Passage;
@end
