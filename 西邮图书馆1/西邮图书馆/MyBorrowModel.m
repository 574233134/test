//
//  MyBorrowModel.m
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/2/10.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import "MyBorrowModel.h"

@implementation MyBorrowModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"title" : @"Title",
             @"department" : @"Department",
             @"state" : @"State",
             @"date" : @"Date",
             @"canRenew":@"CanRenew",
             @"departmentId":@"Department_id",
             @"libraryId":@"Library_id",
             @"barcode":@"Barcode"};
}
@end
