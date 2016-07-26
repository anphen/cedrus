//
//  TLReviseAddressViewController.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-12.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLAddress,TLReviseAddressViewController;


@protocol TLReviseAddressViewControllerDelegate <NSObject>

@optional

-(void)reviseAddressViewController:(TLReviseAddressViewController *)reviseAddressViewController withAddress:(TLAddress *)address;

@end


@interface TLReviseAddressViewController : UIViewController

@property (nonatomic,strong) TLAddress *address;

@property (nonatomic,weak)id<TLReviseAddressViewControllerDelegate>delegate;


@end
