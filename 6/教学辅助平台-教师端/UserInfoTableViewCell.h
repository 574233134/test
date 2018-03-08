//
//  UserInfoTableViewCell.h
//  教学辅助平台-教师端
//
//  Created by 李梦珂 on 2018/1/8.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
@protocol UserInfoTableViewCellDelegate <NSObject>

@required

// cell 的contentTextField的文本发生改变时调用
- (void)contentDidChanged:(NSString *)text forIndexPath:(NSIndexPath *)indexPath;

@end


@interface UserInfoTableViewCell : UITableViewCell<UITextFieldDelegate>
@property CustomTextField *infoTextfield;
@property UILabel *titlelabel;
@property (weak,nonatomic)id<UserInfoTableViewCellDelegate>delegate;
@end
