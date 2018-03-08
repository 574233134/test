//
//  ListViewController.h
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/2/15.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FailedLoding.h"
@interface ListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,FailedLodingDelagate>
@property NSMutableArray *currentArray;
@property NSMutableArray *searchArray;
@property NSMutableArray *borrowArray;
@end
