//
//  UserInfoTableViewCell.m
//  教学辅助平台-教师端
//
//  Created by 李梦珂 on 2018/1/8.
//  Copyright © 2018年 李梦珂. All rights reserved.
//

#import "UserInfoTableViewCell.h"
#import <Masonry.h>
@implementation UserInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self){
        
        _titlelabel = [[UILabel alloc]init];
        [self.contentView addSubview:_titlelabel];
        [_titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(80, 40));
        }];
        
        _infoTextfield = [[CustomTextField alloc]init];
        _infoTextfield.delegate = self;
        [self.infoTextfield addTarget:self action:@selector(contentDidChanged:) forControlEvents:UIControlEventEditingDidEnd];
        [self.contentView addSubview:_infoTextfield];
        [_infoTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.left.equalTo(_titlelabel.mas_right).offset(3);
            make.top.equalTo(_titlelabel.mas_top);
            make.bottom.equalTo(_titlelabel.mas_bottom);
        }];
    }
    return self;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_infoTextfield resignFirstResponder];
}
- (void)contentDidChanged:(id)sender {
    // 调用代理方法，告诉代理，哪一行的文本发生了改变
    if (self.delegate && [self.delegate respondsToSelector:@selector(contentDidChanged:forIndexPath:)]) {
        [self.delegate contentDidChanged:self.infoTextfield.text forIndexPath:self.infoTextfield.indexPath];
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
