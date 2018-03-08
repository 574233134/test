//
//  AnnounceDetilViewController.h
//  西邮图书馆
//
//  Created by 李梦珂 on 2017/1/16.
//  Copyright © 2017年 李梦珂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FailedLoding.h"
@interface DetilViewController : UIViewController<UIWebViewDelegate,FailedLodingDelagate>
@property UIWebView *webview;
@property NSString *Id;
@property UILabel *titleLable;
@property UILabel *publisherLable;
@property UILabel *dateLable;
@property NSString * baseurl;
@property NSUInteger flag;
-(void)network;
@end
