//
//  TLGroupDetailCoupon.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/15.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"

@protocol TLGroupDetailCoupon <NSObject>


@end


@interface TLGroupDetailCoupon : JSONModel

@property (nonatomic,copy) NSString *operator_date;
@property (nonatomic,copy) NSString *amount;
@property (nonatomic,copy) NSString *coupon_id;

@end
