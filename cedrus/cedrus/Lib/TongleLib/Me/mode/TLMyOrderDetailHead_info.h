//
//  TLMyOrderDetailHead_info.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-10.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"

@protocol TLMyOrderDetailHead_info 

@end

@interface TLMyOrderDetailHead_info : JSONModel
/**
 *  订单号
 */
@property (nonatomic,copy) NSString *order_no;
/**
 *  下单时间
 */
@property (nonatomic,copy) NSString *order_time;
/**
 *  订单备注
 */
@property (nonatomic,copy) NSString *order_memo;
/**
 *  商品总数量
 */
@property (nonatomic,copy) NSString *quantity;
/**
 *  订单总金额
 */
@property (nonatomic,copy) NSString *amount;
/**
 *  总运费
 */
@property (nonatomic,copy) NSString *fee_amount;
/**
 *  订单状态
 */
@property (nonatomic,copy) NSString *status;
/**
 *  支付手段
 */
@property (nonatomic,copy) NSString *pay_method;
/**
 *  订单是否可变更
 */
@property (nonatomic,copy) NSString *modify_flag;
/**
 *  订单是否可取消
 */
@property (nonatomic,copy) NSString *cancel_flag;
/**
 *  订单是否可评价
 */
@property (nonatomic,copy) NSString *evaluate_flag;

@property (nonatomic,copy) NSString *tariff;

@property (nonatomic,copy) NSString *customs_flag;

@property (nonatomic,copy) NSString *customs_fail_reason;

@end
