//
//  TLProfitViewController.h
//  TL11
//
//  Created by liu on 15-4-14.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLNavigationBar;


@interface TLProfitViewController : UIViewController

@property (nonatomic,copy)  NSString        *user_id;
@property (nonatomic,copy)  NSString        *token;
@property (nonatomic,copy)  NSString        *json;
@property (nonatomic,strong) TLNavigationBar *navigationBar;

@end
