//
//  TLGroupCouponCode.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/15.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"

@protocol TLGroupCouponCode <NSObject>


@end


@interface TLGroupCouponCode : JSONModel

@property (nonatomic,copy) NSString *coupon_code;

@end
