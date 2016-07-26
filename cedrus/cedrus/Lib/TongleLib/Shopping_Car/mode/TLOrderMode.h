//
//  TLOrderMode.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-15.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"

@interface TLOrderMode : JSONModel


//商品明细列表
@property (nonatomic,strong) NSArray *product_list;
//收货地址编号
@property (nonatomic,copy) NSString *address_no;
//支付方式编号
@property (nonatomic,copy) NSString *pay_type;

@property (nonatomic,copy) NSString *invoice_type;
//配送信息
@property (nonatomic,strong) NSDictionary *shipping_method;
//发票信息
@property (nonatomic,strong) NSDictionary *invoice_info;
//订单备注
@property (nonatomic,copy) NSString *order_memo;


@end
