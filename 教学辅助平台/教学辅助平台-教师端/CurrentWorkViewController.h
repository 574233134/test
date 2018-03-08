//
//  CurrentWorkViewController.h
//  教学辅助平台-教师端
//
//  Created by 李梦珂 on 2018/2/20.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BmobSDK/Bmob.h>
@interface CurrentWorkViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(retain) BmobObject *courseobject;
@end
