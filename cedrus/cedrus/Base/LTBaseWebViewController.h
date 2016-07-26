//
//  LTBaseWebViewController.h
//  cedrus
//
//  Created by X Z on 16/7/20.
//  Copyright © 2016年 LT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebViewJavascriptBridge.h>

@interface LTBaseWebViewController : UIViewController

@property (nonatomic, strong) UIWebView *mainWebView;
@property (nonatomic, strong) WebViewJavascriptBridge *bridge;
@property (nonatomic, copy) NSString *requestURL;

- (void) loadLocalHTML:(NSString *) fileName;

- (void) loadPageWithURL:(NSString *) urlString;

@end
