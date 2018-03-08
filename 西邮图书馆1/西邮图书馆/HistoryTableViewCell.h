//
//  HistoryTableViewCell.h
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/2/2.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryTableViewCell : UITableViewCell
@property UILabel *titleLabel;
//@property UILabel *barcodeLabel;
@property UILabel *typeLabel;
@property UILabel *dateLabel;
-(void)setTitleText:(NSString *)text;
@end
