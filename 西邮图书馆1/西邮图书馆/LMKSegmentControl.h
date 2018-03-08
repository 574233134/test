//
//  LMKSegmentControl.h
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/1/13.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LMKSegmentControl<NSObject>
-(void)changePage:(NSUInteger)page;
//-(void )loadData:( NSString *_Nullable)type andPage:(NSUInteger)page;
@end
@interface LMKSegmentControl : UIControl

@property(nonatomic) NSUInteger numberOfSegments;
@property(nonatomic) NSUInteger selectIndex;
@property(nonatomic, copy, nonnull) NSMutableArray *buttons;
@property (nullable,weak)id <LMKSegmentControl>delagete;
- (void)setItems:(nullable NSArray *)items;
- (void)selected:(nullable UIButton *)selectedButton;
-(void)setSelectIndex:(NSUInteger)selectIndex;
@end
