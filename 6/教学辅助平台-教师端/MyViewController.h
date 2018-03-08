//
//  MyViewController.h
//  教学辅助平台-教师端
//
//  Created by 李梦珂 on 2017/12/30.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property NSMutableArray *dataArray;
@property NSString *name;
@property NSString *userSchool;
@property NSString *teacherID;

@end
