//
//  LMKTableViewCell.m
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/1/15.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import "LMKTableViewCell.h"
#import <Masonry.h>
@implementation LMKTableViewCell
{
    UIImageView *leftview;
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        leftview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"circle"]];
        _textlable = [[UILabel alloc]init];
        [self.contentView addSubview:leftview];
        [self.contentView addSubview:_textlable];
        _textlable.numberOfLines = 2;
        [self.contentView addSubview:leftview];
        [self.contentView addSubview:_textlable];
        
        [leftview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.centerY.equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(10, 10));
        }];
        [_textlable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftview.mas_right).offset(10);
            make.top.equalTo(self.mas_top).offset(5);
            make.right.equalTo(self.mas_right).offset(-20);
            make.bottom.equalTo(self.mas_bottom).offset(-5);
        }];
    }
    return self;
}
@end
