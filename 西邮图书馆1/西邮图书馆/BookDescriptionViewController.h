//
//  BookDescriptionViewController.h
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/2/11.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FailedLoding.h"
@interface BookDescriptionViewController : UIViewController<FailedLodingDelagate>
@property UILabel *titleLabel;
@property UILabel *authorLabel;
@property UILabel *introductionLabel;
@property NSString *barcode;
@property NSDictionary *dataDic;
@property NSString *ID;
-(instancetype)initWithbarcode:(NSString *)barcode;
-(instancetype)initWithID:(NSString *)ID;
@end
