//
//  ListTableViewCell.m
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/2/15.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import "ListTableViewCell.h"
#import "UILabel+AutoFitWidth.h"
#import <Masonry.h>
@implementation ListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubview];
    }
    return self;
}
-(void)creatSubview
{
    _bookNameLabel = [[UILabel alloc]init];
    _bookNameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_bookNameLabel];
}
-(void)setBookName:(NSString *)name
{
    _bookNameLabel.text = name;
    [_bookNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo (self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo([UILabel getHeightByWidth:self.contentView.frame.size.width-20 title:name font:[UIFont systemFontOfSize:15]]);
    }];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
