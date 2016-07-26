//
//  TLGroupCouponPurchaseInfo.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/10.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLGroupContent.h"


@protocol TLGroupCouponPurchaseInfo <NSObject>


@end

@interface TLGroupCouponPurchaseInfo : JSONModel

@property (nonatomic,copy)  NSString *head;
@property (nonatomic,strong)  NSArray<TLGroupContent,ConvertOnDemand> *content_list;
@property (nonatomic,copy)  NSString *content_total_price;
@property (nonatomic,copy)  NSString *content_actually_price;
@property (nonatomic,copy)  NSString *footer;


@end
