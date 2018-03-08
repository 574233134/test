//
//  FootModel.m
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/2/2.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import "FootModel.h"

@implementation FootModel

//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"title" : @"Title",
             @"barcode" : @"Barcode",
             @"type" : @"Type",
             @"date" : @"Date"};
}
@end
