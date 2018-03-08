//
//  NewHomeworkTableViewCell.m
//  教学辅助平台学生端
//
//  Created by 郭挺 on 2018/2/20.
//  Copyright © 2018年 郭挺. All rights reserved.
//

#import "NewHomeworkTableViewCell.h"

@implementation NewHomeworkTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _typeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_typeLabel];
        [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(25);
            make.right.equalTo(self.contentView.mas_right).offset(-25);
            make.height.equalTo(@30);
            make.top.equalTo(self.contentView.mas_top).offset(10);
        }];
        _typeLabel.font = [UIFont systemFontOfSize:20];
        _typeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

@end
