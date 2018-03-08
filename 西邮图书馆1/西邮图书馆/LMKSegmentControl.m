//
//  LMKSegmentControl.m
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/1/13.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import "LMKSegmentControl.h"

@implementation LMKSegmentControl

@synthesize numberOfSegments;
@synthesize buttons;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _selectIndex = 0;
        buttons = [[NSMutableArray alloc]init];
    }
    return self;
}
//设置segmentcontrol的内容
- (void)setItems:(nullable NSArray *)items
{
    
    numberOfSegments = items.count;
    
    float width = self.frame.size.width/items.count;
    for (int i=0; i<items.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = 100+i;
        button.frame = CGRectMake(i*width, 0, width, 40);
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:items[i] forState:UIControlStateNormal];
        button.highlighted = NO;
        if (i==0) {
            button.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
            [self selected:button];
        }
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
        [buttons addObject:button];
        [self addSubview:button];
    }

}
-(void)selected:(UIButton *)selectedButton
{

    NSUInteger index = selectedButton.tag-100;
    [self setSelectIndex:index];
}
-(void)setSelectIndex:(NSUInteger)selectIndex
{
    _selectIndex = selectIndex;
    
    for (UIButton *button in buttons) {
        if (button == buttons[self.selectIndex])
        {
            button.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
        }
        else {
            button.backgroundColor = [UIColor whiteColor];
        }
    }
    [self.delagete changePage:_selectIndex];
}
@end
