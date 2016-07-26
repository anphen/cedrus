//
//  TLAilpay.h
//  tongle
//
//  Created by jixiaofei-mac on 15-8-7.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"

@interface TLAilpay : JSONModel

@property (nonatomic,copy) NSString *service;
@property (nonatomic,copy) NSString *partner;
@property (nonatomic,copy) NSString *input_charset;
@property (nonatomic,copy) NSString *sign_type;
@property (nonatomic,copy) NSString *sign;
@property (nonatomic,copy) NSString *notify_url;
@property (nonatomic,copy) NSString *app_id;
@property (nonatomic,copy) NSString *out_trade_no;
@property (nonatomic,copy) NSString *subject;
@property (nonatomic,copy) NSString *payment_type;
@property (nonatomic,copy) NSString *seller_id;
@property (nonatomic,copy) NSString *total_fee;
@property (nonatomic,copy) NSString *body;
@property (nonatomic,copy) NSString *it_b_pay;
@property (nonatomic,copy) NSString *extern_token;

@end
