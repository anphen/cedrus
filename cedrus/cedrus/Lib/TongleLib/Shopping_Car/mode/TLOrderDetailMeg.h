//
//  TLOrderDetailMeg.h
//  tongle
//
//  Created by jixiaofei-mac on 15-10-30.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLMyShoppingCart.h"

@interface TLOrderDetailMeg : JSONModel

@property (nonatomic,copy)  NSString *total_amount;
@property (nonatomic,copy)  NSString *total_fee;
@property (nonatomic,copy)  NSString *total_tariff;
@property (nonatomic,copy)  NSString *total_goods_count;
@property (nonatomic,copy)  NSString *total_goods_price;
@property (nonatomic,copy)  NSString *vouchers_number_id;
@property (nonatomic,copy)  NSString *vouchers_name;
@property (nonatomic,copy)  NSString *money;
@property (nonatomic,copy)  NSString *use_conditions;
@property (nonatomic,strong)  NSArray<TLMyShoppingCart,ConvertOnDemand> *my_shopping_cart;
//规格列表

@end
