//
//  BookDetailViewController.h
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/2/12.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookDetailViewController : UIViewController
@property NSDictionary *dataDic;
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
