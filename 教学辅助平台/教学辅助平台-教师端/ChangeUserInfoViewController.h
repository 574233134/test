//
//  ChangeUserInfoViewController.h
//  教学辅助平台-教师端
//
//  Created by 李梦珂 on 2018/1/3.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoTableViewCell.h"
typedef void (^UserInfoBlock)(NSDictionary *dic);
@interface ChangeUserInfoViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UserInfoTableViewCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,copy)UserInfoBlock block;
@end
