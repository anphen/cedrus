//
//  TLMyOrderDetailOrder_info.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-10.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLMyOrderDetailHead_info.h"
#import "TLMyOrderDetailList.h"
#import "TLMyOrderDetailAdd_info.h"
#import "TLMyOrderDetailShipping_info.h"
#import "TLMyOrderDetailInvoice_info.h"
#import "TLMyOrderDetailLogistics_info.h"

@protocol TLMyOrderDetailOrder_info 

@end

@interface TLMyOrderDetailOrder_info : JSONModel
//订单头部信息
@property (nonatomic,strong) TLMyOrderDetailHead_info *head_info;
//商品列表

@property (nonatomic,strong) NSArray<TLMyOrderDetailList,ConvertOnDemand> *order_detail;
//收货地址信息
@property (nonatomic,strong) TLMyOrderDetailAdd_info *add_info;
//支付方式编号
@property (nonatomic,strong) NSString *pay_type_id;
//支付方式名称
@property (nonatomic,strong) NSString *pay_type_name;
//配送信息
@property (nonatomic,strong) TLMyOrderDetailShipping_info *shipping_info;
//发票信息
@property (nonatomic,strong) TLMyOrderDetailInvoice_info *invoice_info;
//物流信息
@property (nonatomic,strong) TLMyOrderDetailLogistics_info *logistics_info;

@property (nonatomic,copy) NSString *goods_return_url;

@property (nonatomic,copy) NSString *goods_return_title;

//抵用券券名
@property (nonatomic,copy) NSString *vouchers_name;
//抵用券金额
@property (nonatomic,copy) NSString *money;
//抵用券使用条件
@property (nonatomic,copy) NSString *use_conditions;

@end
