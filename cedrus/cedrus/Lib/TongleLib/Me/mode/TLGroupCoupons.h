//
//  TLGroupCoupons.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/15.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLGroupCouponCode.h"
#import "TLGroupCouponCodeurlInfo.h"

@protocol TLGroupCoupons <NSObject>


@end

@interface TLGroupCoupons : JSONModel

@property (nonatomic,copy) NSString *order_no;
@property (nonatomic,copy) NSString *prod_name;
@property (nonatomic,copy) NSString *mstore_id;
@property (nonatomic,copy) NSString *mstore_name;
@property (nonatomic,copy) NSString *overdue_date_from;
@property (nonatomic,copy) NSString *overdue_date_to;
@property (nonatomic,copy) NSString *out_of_date;
@property (nonatomic,strong) TLGroupCouponCodeurlInfo *coupon_codeurl_info;
@property (nonatomic,strong) NSArray<TLGroupCouponCode,ConvertOnDemand> *coupon_code_list;




@end
