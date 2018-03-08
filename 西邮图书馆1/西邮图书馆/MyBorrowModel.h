//
//  MyBorrowModel.h
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/2/10.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyBorrowModel : NSObject
@property NSString *title;
@property NSString *department;
@property NSString *state;
@property NSString *date;
@property BOOL canRenew;
@property NSString *barcode;
@property NSString *departmentId;
@property NSString *libraryId;
@end
