//
//  BaseViewController+Loading.h
//  bang5mai
//
//  Created by y on 15/9/23.
//  Copyright © 2015年 xiaolang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebLoadingView : UIView

@property (nonatomic, weak) UIView *parentView;

- (void) showWithTitle:(NSString * )title;

@end

#pragma mark --
#pragma mark -- BaseViewController (Loading)

@interface UIViewController (Loading)

@property (nonatomic, strong) WebLoadingView *webLoadingView;

@property (nonatomic, strong, readonly) UIActivityIndicatorView *activityView;


- (void) showWebLoadingView;

- (void) hideWebLoadingView;

- (void) showActivityView;

- (void) hideActivityView;
@end
