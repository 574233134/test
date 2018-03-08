//
//  HistoryTableViewCell.m
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/2/2.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import "HistoryTableViewCell.h"
#import <Masonry.h>
#import "UILabel+AutoFitWidth.h"
@implementation HistoryTableViewCell
{
//    UILabel *shapecodeLabel;
    UILabel *stateLabel;
    UILabel *timeLabel;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self initSubviews];
    }
    return self;
}
-(void)initSubviews
{
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_titleLabel];
    _typeLabel = [[UILabel alloc]init];
    _typeLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_typeLabel];
    _dateLabel = [[UILabel alloc]init];
    _dateLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_dateLabel];
    stateLabel = [[UILabel alloc]init];
    stateLabel.font  = [UIFont systemFontOfSize:13];
    stateLabel.text = @"状态:";
    [self addSubview:stateLabel];
    timeLabel = [[UILabel alloc]init];
    timeLabel.font = [UIFont systemFontOfSize:13];
    timeLabel.text = @"操作时间:";
    [self addSubview:timeLabel];
    [stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_left);
        make.top.equalTo(_titleLabel.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(35, 20));
    }];
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(stateLabel.mas_right);
        make.top.equalTo(stateLabel.mas_top);
        make.size.mas_equalTo(CGSizeMake(30, 20));
    }];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(stateLabel.mas_left);
        make.top.equalTo(stateLabel.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeLabel.mas_right);
        make.top.equalTo(timeLabel.mas_top);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
}
//---------------------------titlelabel高度自适应----------------------------------
-(void)setTitleText:(NSString *)text
{

    //高度自适应
    _titleLabel.text = text;
    _titleLabel.frame = CGRectMake(15, 10, [UIScreen mainScreen].bounds.size.width-30, [self getHeightWith:text systemFontOfSize:15 labelWidth:[UIScreen mainScreen].bounds.size.width-30]);
}
-(CGFloat)getHeightWith:(NSString *) text systemFontOfSize:(CGFloat) size labelWidth:(CGFloat) width
{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:size]};
    CGSize cgsize = [text boundingRectWithSize:CGSizeMake(width, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return cgsize.height;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
