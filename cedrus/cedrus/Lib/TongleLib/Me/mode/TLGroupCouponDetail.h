//
//  TLGroupCouponDetail.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/15.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLGroupOrderProdBaseInfo.h"
#import "TLGroupCouponCodeurlInfo.h"
#import "TLGroupCouponStoreInfo.h"
#import "TLGroupCouponPurchaseInfo.h"
#import "TLGroupCouponPurchaseNotice.h"


@interface TLGroupCouponDetail : JSONModel

@property (nonatomic,strong) TLGroupOrderProdBaseInfo *prod_base_info;
@property (nonatomic,strong) TLGroupCouponCodeurlInfo *coupon_codeurl_info;
@property (nonatomic,strong) TLGroupCouponStoreInfo *coupon_store_info;
@property (nonatomic,strong) TLGroupCouponPurchaseInfo *coupon_purchase_info;
@property (nonatomic,strong) NSArray<TLGroupCouponPurchaseNotice,ConvertOnDemand>  *coupon_purchase_notice_list;

@end
