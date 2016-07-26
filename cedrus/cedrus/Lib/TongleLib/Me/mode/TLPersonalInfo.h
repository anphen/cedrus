//
//  TLPersonalInfo.h
//  tongle
//
//  Created by jixiaofei-mac on 15-9-29.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"

@interface TLPersonalInfo : JSONModel

@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString *user_name;
@property (nonatomic,copy) NSString *user_nick_name;
@property (nonatomic,copy) NSString *user_phone;
@property (nonatomic,copy) NSString *user_photo_url;
@property (nonatomic,copy) NSString *user_sex;
@property (nonatomic,copy) NSString *user_id_no;
@property (nonatomic,copy) NSString *user_sales_point;
@property (nonatomic,copy) NSString *user_rebate_point;
@property (nonatomic,copy) NSString *user_account_balance;
@property (nonatomic,copy) NSString *user_coupons;
@property (nonatomic,copy) NSString *user_fans;
@property (nonatomic,copy) NSString *user_follows;
@property (nonatomic,copy) NSString *user_qr_code_url;
@property (nonatomic,copy) NSString *user_customs_flag;


@end
