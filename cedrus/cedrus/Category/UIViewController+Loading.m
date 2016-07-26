//
//  BaseViewController+Loading.m
//  bang5mai
//
//  Created by y on 15/9/23.
//  Copyright © 2015年 xiaolang. All rights reserved.
//

#import "UIViewController+Loading.h"
#include <objc/runtime.h>

@interface WebLoadingView()

@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIImageView *loadingImageView;

@end

#pragma mark --
#pragma mark -- WebLoadingView

@implementation WebLoadingView

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        [self addSubview:self.tipLabel];
        [self addSubview:self.loadingImageView];
    }
    return self;
}

- (UIImageView *)loadingImageView {
    if (!_loadingImageView) {
        _loadingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) / 2 - 25 / 2, CGRectGetHeight(self.frame) / 2, 25, 25)];
        NSMutableArray *animationImages = [NSMutableArray array];
        for (int i = 1; i < 11; i++) {
            NSString *name = [NSString stringWithFormat:@"loading-%@",@(i).stringValue];
            
            [animationImages addObject:[UIImage imageNamed:name]];
        }
        _loadingImageView.animationImages = animationImages;
    }
    return _loadingImageView;
}

- (UILabel *) tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height/2 - 20  , self.bounds.size.width, 40)];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.text = @"正在加载数据...";
        _tipLabel.textColor = [UIColor grayColor];
        _tipLabel.alpha = 0.7f;
        _tipLabel.backgroundColor = kClearColor;
    }
    return _tipLabel;
}

- (void) showWithTitle:(NSString *)title {
//    self.tipLabel.text = title;
    [self.loadingImageView startAnimating];
    [self.parentView addSubview:self];
    [self.parentView bringSubviewToFront:self];
}

@end

#pragma mark --
#pragma mark -- BaseWebViewController (Loading)

@implementation UIViewController (Loading)
static char WEB_LOADING_VIEW_TAG;
static char WEB_ACTIVITY_VIEW_TAG;

- (void) setWebLoadingView:(WebLoadingView *)webLoadingView {
    objc_setAssociatedObject(self, &WEB_LOADING_VIEW_TAG, webLoadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (WebLoadingView *) webLoadingView {
    return objc_getAssociatedObject(self, &WEB_LOADING_VIEW_TAG);
}

- (void) setActivityView:(UIActivityIndicatorView *)activityView {
    objc_setAssociatedObject(self, &WEB_ACTIVITY_VIEW_TAG, activityView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIActivityIndicatorView *)activityView
{
    return objc_getAssociatedObject(self, &WEB_ACTIVITY_VIEW_TAG);
}


- (void) showWebLoadingView{
    if (!self.webLoadingView) {
        self.webLoadingView = [[WebLoadingView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
        self.webLoadingView.parentView = self.view;
        CGPoint point = self.view.center;
        point.y -= 100;
        self.webLoadingView.center = point;
    }
    [self.webLoadingView showWithTitle:@"正在加载数据..."];
}

- (void) hideWebLoadingView {
    if (self.webLoadingView) {
        [self.webLoadingView removeFromSuperview];
    }
}

- (void) showActivityView {
    if (!self.activityView) {
        self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self.activityView setColor:[UIColor colorWithRed:0.35 green:0.76 blue:0.98 alpha:1.00]];
        CGPoint point = self.view.center;
        point.y -= 100;
        self.activityView.center = point;
        [self.activityView hidesWhenStopped];
        self.activityView.autoresizingMask = (UIViewAutoresizingFlexibleBottomMargin |
                                              UIViewAutoresizingFlexibleTopMargin |
                                              UIViewAutoresizingFlexibleRightMargin |
                                              UIViewAutoresizingFlexibleLeftMargin);
        [self.view addSubview:self.activityView];
    }
    [self.activityView startAnimating];
}

- (void) hideActivityView {
    [self.activityView stopAnimating];
}

@end
