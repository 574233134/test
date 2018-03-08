//
//  AppDelegate.m
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/1/13.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBar.h"
#import "Publicinfo.h"
#import <AFNetworking.h>
@interface AppDelegate ()

@end

@implementation AppDelegate




- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    MainTabBar *maintabbarvc = [[MainTabBar alloc]init];
    self.window.rootViewController = maintabbarvc;
    [self.window makeKeyAndVisible];
//    AFNetworkReachabilityStatusUnknown          = -1,
//    AFNetworkReachabilityStatusNotReachable     = 0,
//    AFNetworkReachabilityStatusReachableViaWWAN = 1,
//    AFNetworkReachabilityStatusReachableViaWiFi = 2,
        AFNetworkReachabilityManager *manager =[AFNetworkReachabilityManager sharedManager];
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            [Publicinfo sharedPublicinfo].networkState = status;
        }];
        
        [manager startMonitoring];

    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
