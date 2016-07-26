//
//  TLGroupCouponVoucherAll.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/22.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLGroupCouponVoucher.h"


@interface TLGroupCouponVoucherAll : JSONModel

@property (nonatomic,strong) NSArray<TLGroupCouponVoucher,ConvertOnDemand> *voucher;

@end
