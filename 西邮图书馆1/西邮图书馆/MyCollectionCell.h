//
//  MyCollectionCell.h
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/2/6.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MyCollectionCellDelegate<NSObject>
@required
-(void)reLoadInfo:(NSInteger)row;
-(void)present:(UIAlertController *)alertVc;
@end
@interface MyCollectionCell : UITableViewCell

@property NSString *Id;
@property UIImageView *bookImage;
@property UILabel *titleLabel;
@property UILabel *authorLabel;
@property UILabel *publisherLabel;
@property UILabel *indexLabel;
@property NSInteger row;
@property id<MyCollectionCellDelegate>delegate;
@end
