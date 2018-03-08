//
//  MyCollectionViewController.h
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/2/6.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FailedLoding.h"
#import "MyCollectionCell.h"
@interface MyCollectionViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,FailedLodingDelagate,MyCollectionCellDelegate>
@property NSMutableArray *dataArray;
@end
