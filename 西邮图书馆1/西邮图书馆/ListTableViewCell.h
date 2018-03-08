//
//  ListTableViewCell.h
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/2/15.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTableViewCell : UITableViewCell
@property UILabel *bookNameLabel;
-(void)setBookName:(NSString *)name;
@end
