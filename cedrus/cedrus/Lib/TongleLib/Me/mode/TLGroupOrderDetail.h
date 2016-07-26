//
//  TLGroupOderDetail.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/15.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLGroupOrderBase.h"
#import "TLGroupCouponCodeurlInfo.h"
#import "TLGroupDetailCoupon.h"



@interface TLGroupOrderDetail : JSONModel

@property (nonatomic,strong) TLGroupOrderBase *order_base;
@property (nonatomic,strong) TLGroupCouponCodeurlInfo *coupon_codeurl_info;
@property (nonatomic,strong) NSArray<TLGroupDetailCoupon,ConvertOnDemand> *unused_coupon_list;
@property (nonatomic,strong) NSArray<TLGroupDetailCoupon,ConvertOnDemand> *refund_coupon_list;
@property (nonatomic,strong) NSArray<TLGroupDetailCoupon,ConvertOnDemand> *used_coupon_list;
@property (nonatomic,strong) NSArray<TLGroupDetailCoupon,ConvertOnDemand> *expire_coupon_list;
@property (nonatomic,strong) NSArray<TLGroupDetailCoupon,ConvertOnDemand> *refunding_coupon_list;
@end
