//
//  TLGroupOrderList.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/15.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLGroupOrder.h"


@interface TLGroupOrderList : JSONModel

@property (nonatomic,copy) NSString *data_total_count;

@property (nonatomic,strong) NSArray<TLGroupOrder,ConvertOnDemand> *order_list;

@end
