//
//  TLMyOrder.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-8.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLMyOrderList.h"
@interface TLMyOrder : JSONModel

//订单总数
@property (nonatomic,copy) NSString *data_total_count;
//订单列表
@property (nonatomic,strong) NSArray<TLMyOrderList,ConvertOnDemand> *order_list;


@end
