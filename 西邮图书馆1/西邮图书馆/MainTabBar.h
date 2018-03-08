//
//  MainTabBar.h
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/1/13.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTabBar : UITabBarController
- (void)createVC:(UIViewController *)vc Title:(NSString *)title imageName:(NSString *)imageName;
@end
