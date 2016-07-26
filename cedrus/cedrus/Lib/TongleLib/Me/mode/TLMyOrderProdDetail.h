//
//  TLMyOrderProdDetail.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-8.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLMyOrderProdSpecList.h"

@protocol TLMyOrderProdDetail <NSObject>

@end

@interface TLMyOrderProdDetail : JSONModel
//订单明细编号
@property (nonatomic,copy) NSString *order_detail_no;
//商品缩略图URL
@property (nonatomic,copy) NSString *prod_pic_url;
//商品编码
@property (nonatomic,copy) NSString *prod_id;
//商品名称
@property (nonatomic,copy) NSString *prod_name;
//价格
@property (nonatomic,copy) NSString *price;
//数量
@property (nonatomic,copy) NSString *quantity;
//商品规格列表
@property (nonatomic,strong) NSArray<TLMyOrderProdSpecList,ConvertOnDemand> *prod_spec_list;

@property (nonatomic,copy) NSString *country_pic_url;

@property (nonatomic,copy) NSString *import_info_desc;

@property (nonatomic,copy) NSString *transfer_fee_desc;

@property (nonatomic,copy) NSString *tariff_desc;

@property (nonatomic,copy) NSString *import_goods_flag;

@property (nonatomic,copy) NSString *customs_flag;



//
//（订单明细编号，商品缩略图URL，商品编码，商品名称，价格，数量，商品规格列表（规格编号，规格名称，规格明细编号，规格明细名称）
@end
