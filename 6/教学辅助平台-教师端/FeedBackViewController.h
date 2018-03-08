//
//  FeedBackViewController.h
//  教学辅助平台-教师端
//
//  Created by 李梦珂 on 2018/2/10.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedBackViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate>
@property (assign,nonatomic)NSIndexPath *selIndex;

@end
