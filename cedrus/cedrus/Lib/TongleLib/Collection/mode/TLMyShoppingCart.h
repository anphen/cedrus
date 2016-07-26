//
//  TLMyShoppingCart.h
//  tongle
//
//  Created by jixiaofei-mac on 15-11-2.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLProdSpecList_size.h"


@protocol TLMyShoppingCart

@end

@interface TLMyShoppingCart : JSONModel

//规格列表
@property (nonatomic,strong) NSArray<TLProdSpecList_size,ConvertOnDemand> *prod_spec_list;
@property (nonatomic,copy)  NSString *seq_no;
@property (nonatomic,copy)  NSString *post_id;
@property (nonatomic,copy)  NSString *prod_pic_url;
@property (nonatomic,copy)  NSString *prod_id;
@property (nonatomic,copy)  NSString *prod_name;
@property (nonatomic,copy)  NSString *mstore_id;

@property (nonatomic,copy)  NSString *mstore_name;
@property (nonatomic,copy)  NSString *price;
@property (nonatomic,copy)  NSString *order_qty;
@property (nonatomic,copy)  NSString *amount;
@property (nonatomic,copy)  NSString *fee_amount;
@property (nonatomic,copy)  NSString *relation_id;

@property (nonatomic,copy)  NSString *country_pic_url;
@property (nonatomic,copy)  NSString *import_info_desc;
@property (nonatomic,copy)  NSString *transfer_fee_desc;
@property (nonatomic,copy)  NSString *tariff_desc;
@property (nonatomic,copy)  NSString *tariff;
@property (nonatomic,copy)  NSString *import_goods_flag;


@end
