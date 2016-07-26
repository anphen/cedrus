//
//  TLGroupCouponStoreInfo.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/10.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLGroupStoreList.h"

@protocol TLGroupCouponStoreInfo <NSObject>


@end

@interface TLGroupCouponStoreInfo : JSONModel


@property (nonatomic,copy)  NSString *store_total_count;

@property (nonatomic,strong)  NSArray<TLGroupStoreList,ConvertOnDemand> *store_list;

@end
