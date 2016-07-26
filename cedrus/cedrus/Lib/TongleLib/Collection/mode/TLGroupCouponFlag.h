//
//  TLGroupCouponFlag.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/10.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"

@protocol TLGroupCouponFlag <NSObject>


@end


@interface TLGroupCouponFlag : JSONModel


@property (nonatomic,copy)  NSString *ready_to_retire_flg;

@property (nonatomic,copy)  NSString *expired_refund_flg;

@property (nonatomic,copy)  NSString *non_refundable_flg;



@end
