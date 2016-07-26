//
//  TLSearchViewController.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-24.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLNavigationBar,TLSearch,TLSearchViewController;


@protocol TLSearchViewControllerDelegate <NSObject>

@optional

-(void)searchViewController:(TLSearchViewController *)SearchViewController;

@end

@interface TLSearchViewController : UIViewController
@property (nonatomic,weak)      TLNavigationBar *navigationBar;
@property (nonatomic,weak)      UITextField     *find;
@property (nonatomic,strong)    TLSearch        *searchModel;
@property (nonatomic,copy)      NSString        *find_type;
@property (nonatomic,copy)      NSString        *find_key;
@property (nonatomic,copy)      NSString        *user_id;
@property (nonatomic,copy)      NSString        *token;
@property (nonatomic,copy)      NSString        *style;

@property (nonatomic,strong) id<TLSearchViewControllerDelegate>delegate;

@end
