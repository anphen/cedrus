//
//  TLCouponStoreInfo.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/9.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLGroupStore.h"


@interface TLCouponStoreInfo : JSONModel

@property (nonatomic,assign)  NSInteger store_total_count;
@property (nonatomic,strong)  NSArray<TLGroupStore,ConvertOnDemand> *store_list;

@end
