//
//  TLMyOrderDetailShipping_info.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-10.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"

@protocol TLMyOrderDetailShipping_info 


@end

@interface TLMyOrderDetailShipping_info : JSONModel
/**
 *  配送方式编号
 */
@property (nonatomic,copy) NSString *shipping_method_no;
/**
 *  配送方式名称
 */
@property (nonatomic,copy) NSString *shipping_method_name;
/**
 *  配送时间
 */
@property (nonatomic,copy) NSString *shipping_time_memo;

@end
