//
//  CollectionModel.m
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/2/6.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import "CollectionModel.h"

@implementation CollectionModel
//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"title" : @"Title",
             @"publisher" : @"Pub",
             @"sort" : @"Sort",
             @"author" : @"Author",
             @"images":@"Images",
             @"Id":@"ID"};
}

@end
