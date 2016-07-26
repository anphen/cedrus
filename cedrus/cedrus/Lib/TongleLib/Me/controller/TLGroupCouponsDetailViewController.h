//
//  TLGroupCouponsDetailViewController.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/18.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLGroupCoupons,TLGroupCouponCode;

@interface TLGroupCouponsDetailViewController : UIViewController

@property (nonatomic,strong) TLGroupCoupons    *groupCoupons;
@property (nonatomic,strong) TLGroupCouponCode *groupCouponCode;

@end
