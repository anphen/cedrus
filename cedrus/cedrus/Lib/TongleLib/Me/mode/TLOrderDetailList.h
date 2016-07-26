//
//  TLOrderDetailList.h
//  tongle
//
//  Created by jixiaofei-mac on 15-7-17.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLMyOrderList.h"

@interface TLOrderDetailList : JSONModel

@property (nonatomic,strong) TLMyOrderList *orderList;
@property (nonatomic,copy) NSString *order_no;

@end
