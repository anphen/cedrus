//
//  TLMyOrderList.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-8.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLMyOrderProdDetail.h"

@protocol TLMyOrderList <NSObject>

@end

@interface TLMyOrderList : JSONModel
//订单号
@property (nonatomic,copy) NSString *order_no;
//订单金额
@property (nonatomic,copy) NSString *amount;
//总运费
@property (nonatomic,copy) NSString *fee_amount;
//下单时间
@property (nonatomic,copy) NSString *order_time;
//订单状态
@property (nonatomic,copy) NSString *status;
//支付手段
@property (nonatomic,copy) NSString *pay_method;
//订单是否可变更
@property (nonatomic,copy) NSString *modify_flag;
//订单是否可取消
@property (nonatomic,copy) NSString *cancel_flag;
//订单是否可评价
@property (nonatomic,copy) NSString *evaluate_flag;
//订单商品明细列表
@property (nonatomic,strong) NSArray<TLMyOrderProdDetail,ConvertOnDemand> *prod_detail;
//抵用券券名
@property (nonatomic,copy) NSString *vouchers_name;
//抵用券金额
@property (nonatomic,copy) NSString *money;
//抵用券使用条件
@property (nonatomic,copy) NSString *use_conditions;



@end
