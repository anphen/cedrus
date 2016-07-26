//
//  TLGroupProductDetail.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/10.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLGroupProdBaseInfo.h"
#import "TLGroupCouponFlag.h"
#import "TLGroupCouponStoreInfo.h"
#import "TLGroupCouponPurchaseInfo.h"
#import "TLGroupCouponPurchaseNotice.h"
#import "TLGroupUiBtnControlList.h"

@interface TLGroupProductDetail : JSONModel

@property (nonatomic,strong) TLGroupProdBaseInfo *prod_base_info;
@property (nonatomic,strong) TLGroupCouponFlag   *coupon_flag;
@property (nonatomic,strong) TLGroupCouponStoreInfo  *coupon_store_info;
@property (nonatomic,strong) TLGroupCouponPurchaseInfo  *coupon_purchase_info;
@property (nonatomic,strong) NSArray<TLGroupCouponPurchaseNotice,ConvertOnDemand>  *coupon_purchase_notice_list;
@property (nonatomic,strong) NSArray<TLGroupUiBtnControlList,ConvertOnDemand>  *ui_btn_control_list;

@end
