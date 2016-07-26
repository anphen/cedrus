//
//  TLGroupCouponVoucher.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/22.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLGroupCouponVoucherBase.h"
#import "TLGroupCouponVoucherLinkInfo.h"

@protocol TLGroupCouponVoucher <NSObject>


@end


@interface TLGroupCouponVoucher : JSONModel

@property (nonatomic,strong) TLGroupCouponVoucherBase *voucher_base;
@property (nonatomic,strong) TLGroupCouponVoucherLinkInfo *voucher_link_info;


@end
