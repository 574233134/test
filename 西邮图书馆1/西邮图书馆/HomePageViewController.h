//
//  HomePageViewController.h
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/1/13.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMKSegmentControl.h"
#import "FailedLoding.h"
@interface HomePageViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,LMKSegmentControl,FailedLodingDelagate>
@property (nullable)LMKSegmentControl *segment;
@property (nullable)UITableView *tableviewnews;//新闻
@property (nullable)UITableView *tableviewannounce;//公告
@property (nullable)UIScrollView *scrolView;
@property NSUInteger NewsPage;
@property NSUInteger AnnouncePage;
@property(nullable)NSMutableArray *newsarray;
@property(nullable)NSMutableArray *announcearray;
@end
