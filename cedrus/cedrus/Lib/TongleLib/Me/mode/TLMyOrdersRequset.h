//
//  TLMyOrdersRequset.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-8.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLCommon.h"

@interface TLMyOrdersRequset : NSObject

//用户ID（必须指定）
@property (nonatomic,copy) NSString *user_id;
//订单状态过滤条件（可为空）
@property (nonatomic,copy) NSString *order_status;
//时间期间From（可为空）
@property (nonatomic,copy) NSString *order_date_from;
//时间期间To（可为空）
@property (nonatomic,copy) NSString *order_date_to;
//订单号（可为空）
@property (nonatomic,copy) NSString *order_no;
//翻页方向（向前翻或向后翻）（可为空）
@property (nonatomic,copy) NSString *forward;
//返回条数（可为空）
@property (nonatomic,copy) NSString *fetch_count;

@property (nonatomic,copy) NSString *TL_USER_TOKEN_REQUEST;


@end
