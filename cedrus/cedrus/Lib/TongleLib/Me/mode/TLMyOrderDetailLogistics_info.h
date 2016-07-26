//
//  TLMyOrderDetailLogistics_info.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-10.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"


@protocol TLMyOrderDetailLogistics_info 


@end

@interface TLMyOrderDetailLogistics_info : JSONModel
/**
 *  承运公司名称
 */
@property (nonatomic,copy) NSString *shipping_company;
/**
 *  运单号码
 */
@property (nonatomic,copy) NSString *shipping_no;
/**
 *  发货时间
 */
@property (nonatomic,copy) NSString *shipping_time;


@end