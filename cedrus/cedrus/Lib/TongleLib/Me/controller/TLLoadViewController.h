//
//  TLLoadViewController.h
//  TL11
//
//  Created by liu on 15-4-14.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLNavigationBar;


@interface TLLoadViewController : UIViewController

@property (nonatomic,weak) TLNavigationBar *navigationBar;
@property (nonatomic,copy) NSString *iosUrl;
@property (nonatomic,weak) UIImageView *iosImage;


@end
