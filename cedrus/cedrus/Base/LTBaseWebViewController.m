//
//  LTBaseWebViewController.m
//  cedrus
//
//  Created by X Z on 16/7/20.
//  Copyright © 2016年 LT. All rights reserved.
//

#import "LTBaseWebViewController.h"
#import <UIScrollView+SVPullToRefresh.h>
#import <UIScrollView+SVInfiniteScrolling.h>
#import "UIViewController+Loading.h"
#import <Masonry.h>
#import "UIColor+extend.h"

@interface LTBaseWebViewController () <UIWebViewDelegate, UIScrollViewDelegate>

@end

@implementation LTBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: self.mainWebView];
    [self.mainWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    [self configScrollView];
    [self configJavascriptBridge];
    if (self.requestURL) {
        [self loadPageWithURL:self.requestURL];
    }
}

- (void)configJavascriptBridge
{
    [WebViewJavascriptBridge enableLogging];
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.mainWebView];
    [self.bridge setWebViewDelegate:self];
    [self.bridge registerHandler:@"" handler:^(id data, WVJBResponseCallback responseCallback) {
//        [];
    }];
    
}

- (void)configScrollView
{
    __weak typeof(self) weakSelf = self;
    [self.mainWebView.scrollView addPullToRefreshWithActionHandler:^{
        NSString *URL = [[[weakSelf.mainWebView request] URL] absoluteString];
        if (0 == [URL length] || NSOrderedSame == [@"about:blank" caseInsensitiveCompare:URL])
        {
            URL = self.requestURL;
        }
        [weakSelf loadPageWithURL:URL];
    }];
    [self.mainWebView.scrollView addInfiniteScrollingWithActionHandler:^{
    }];

    [self.mainWebView.scrollView.pullToRefreshView setTextColor:kCustomGrayColor];
    [self.mainWebView.scrollView.pullToRefreshView setArrowColor:kCustomGrayColor];
    [self.mainWebView.scrollView.pullToRefreshView setTitle:@"下拉刷新"
                                                   forState:SVPullToRefreshStateStopped];
    [self.mainWebView.scrollView.pullToRefreshView setTitle:@"释放刷新"
                                                   forState:SVPullToRefreshStateTriggered];
    [self.mainWebView.scrollView.pullToRefreshView setTitle:@"努力加载中..."
                                                   forState:SVPullToRefreshStateLoading];

    [self.mainWebView.scrollView setShowsPullToRefresh:YES];
    [self.mainWebView.scrollView setShowsInfiniteScrolling:NO];
}


- (void) loadLocalHTML:(NSString *) fileName
{
    if (!fileName) {
        return;
    }
    NSString* path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"html"];
    if (path) {
        NSURL* url = [NSURL fileURLWithPath:path];
        NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
        [self.mainWebView loadRequest:request];
        _mainWebView.scalesPageToFit = NO;
    }
}

- (void) loadPageWithURL:(NSString *) urlString
{
    [self.mainWebView loadRequest:[NSURLRequest  requestWithURL:[NSURL URLWithString:urlString]]];
}


#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView
    shouldStartLoadWithRequest:(NSURLRequest *)request
                navigationType:(UIWebViewNavigationType)navigationType
{
    
    LTLog(@"%zi || URL = %@\npathComponents = %@\nparameterString = %@\nnavigationType = %ld\n", navigationType, request.URL, request.URL.pathComponents,
          request.URL.parameterString, (long)navigationType);
    if ([request.URL.absoluteString isEqualToString:self.requestURL] || (navigationType == UIWebViewNavigationTypeLinkClicked))
    {
        return YES;
    }

    NSString *urlScheme = request.URL.scheme;
    

    if ([urlScheme isEqualToString:@"http"] || [urlScheme isEqualToString:@"https"])
    {
        LTBaseWebViewController *secondWebViewController = [[LTBaseWebViewController alloc] init];
        secondWebViewController.requestURL = request.URL.absoluteString;
        [self.navigationController pushViewController:secondWebViewController animated:YES];
    }

    return NO;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self showActivityView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self.mainWebView.scrollView.pullToRefreshView stopAnimating];
    [self hideActivityView];
}

#pragma mark - getters and setters
- (UIWebView *)mainWebView
{
    if (!_mainWebView) {
        _mainWebView = [[UIWebView alloc]init];
        _mainWebView.backgroundColor = [UIColor whiteColor];
        _mainWebView.scalesPageToFit = YES;
        _mainWebView.delegate = self;
        _mainWebView.scrollView.delegate = self;
        _mainWebView.opaque = NO;
    }
    return _mainWebView;
}

@end
