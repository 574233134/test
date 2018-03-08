//
//  MyBorrowTableViewCell.h
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/2/10.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MyBorrowTableViewCellDelegate<NSObject>
@required
-(void)reloadInfo:(NSInteger)row;
-(void)present:(UIAlertController *)alert;
@end
@interface MyBorrowTableViewCell : UITableViewCell
@property UILabel *titleLabel;
@property UILabel *departmentLabel;
@property UILabel *stateLabel;
@property UILabel *dateLabel;
@property UIButton *renewButton;
@property BOOL canRenew;
@property NSInteger row;
@property NSString *barcode;
@property NSString *departmentId;
@property NSString *libraryId;
@property id<MyBorrowTableViewCellDelegate>delegate;
-(void)setTitleText:(NSString *)text;
@end
