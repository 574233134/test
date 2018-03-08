//
//  MyBorrowViewController.h
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/2/7.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBorrowTableViewCell.h"
#import "FailedLoding.h"
@interface MyBorrowViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,FailedLodingDelagate,MyBorrowTableViewCellDelegate>
@property NSMutableArray *dataArray;
@end
