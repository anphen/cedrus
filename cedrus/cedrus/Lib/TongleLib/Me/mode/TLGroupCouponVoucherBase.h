//
//  TLGroupCouponVoucherBase.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/22.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"

@protocol TLGroupCouponVoucherBase <NSObject>


@end

@interface TLGroupCouponVoucherBase : JSONModel

@property (nonatomic,copy) NSString *vouchers_number_id;
@property (nonatomic,copy) NSString *vouchers_name;
@property (nonatomic,copy) NSString *issue_flg;
@property (nonatomic,copy) NSString *issue_store_name;
@property (nonatomic,copy) NSString *money;
@property (nonatomic,copy) NSString *use_conditions;
@property (nonatomic,copy) NSString *use_conditions_memo;
@property (nonatomic,copy) NSString *expiration_date_begin;
@property (nonatomic,copy) NSString *expiration_date_end;
@property (nonatomic,copy) NSString *vouchers_status;


@end
