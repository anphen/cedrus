//
//  TLMyOrderDetail.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-10.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLMyOrderDetailOrder_info.h"

@protocol TLMyOrderDetail


@end

@interface TLMyOrderDetail : JSONModel

@property (nonatomic,strong) TLMyOrderDetailOrder_info *order_info;

@end
