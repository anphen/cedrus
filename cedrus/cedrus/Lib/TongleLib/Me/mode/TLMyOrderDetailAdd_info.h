//
//  TLMyOrderDetailAdd_info.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-10.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"

@protocol TLMyOrderDetailAdd_info 


@end

@interface TLMyOrderDetailAdd_info : JSONModel

/**
 *  地址编号
 */
@property (nonatomic,copy) NSString *address_no;
/**
 *  收货人姓名
 */
@property (nonatomic,copy) NSString *consignee;
/**
 *  电话
 */
@property (nonatomic,copy) NSString *tel;
/**
 *  收货省市
 */
@property (nonatomic,copy) NSString *province;
/**
 *  收货区县
 */
@property (nonatomic,copy) NSString *area;
/**
 *  详细地址
 */
@property (nonatomic,copy) NSString *address;
@end
