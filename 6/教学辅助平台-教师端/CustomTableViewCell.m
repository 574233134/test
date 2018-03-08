//
//  CustomTableViewCell.m
//  看看
//
//  Created by 李梦珂 on 2018/2/10.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "CustomTableViewCell.h"
#import <Masonry.h>
@implementation CustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

 - (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
 {
         self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
         if (self) {
             _select_ima = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"圆形_未选中"]];
             [_select_ima setHighlightedImage:[UIImage imageNamed:@"圆形_选中"]];
             [self.contentView addSubview:_select_ima];
             [_select_ima mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.centerY.equalTo(self.contentView.mas_centerY);
                 make.left.equalTo(self.contentView.mas_left).offset(15);
                 make.size.mas_equalTo(CGSizeMake(18, 18));
                 
             }];

             _feedbackType = [[UILabel alloc]init];
             [self.contentView addSubview:_feedbackType];
             [_feedbackType mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.left.equalTo(_select_ima.mas_right).offset(10);
                 make.right.equalTo(self.contentView.mas_right).offset(-15);
                 make.height.mas_equalTo(@44);
             }];
             
             
             }
         return self;
}
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    _select_ima.highlighted = !_select_ima.isHighlighted;
//}
@end
