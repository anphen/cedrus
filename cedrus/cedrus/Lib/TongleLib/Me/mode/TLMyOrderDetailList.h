//
//  TLMyOrderDetailList.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-10.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLMyOrderProdSpecList.h"

@protocol TLMyOrderDetailList

@end

@interface TLMyOrderDetailList : JSONModel

/**
 *  订单明细编号
 */
@property (nonatomic,copy) NSString *order_detail_no;

/**
 *  商品可评价区分
 */
//@property (nonatomic,copy) NSString *goods_eva_flag;
/**
 *  商品缩略图URL
 */
@property (nonatomic,copy) NSString *prod_pic_url;
/**
 *  商品ID
 */
@property (nonatomic,copy) NSString *prod_id;
/**
 *  帖子ID
 */
@property (nonatomic,copy) NSString *post_id;
/**
 *  商品名称
 */
@property (nonatomic,copy) NSString *prod_name;
/**
 *  单价
 */
@property (nonatomic,copy) NSString *price;
/**
 *  数量
 */
@property (nonatomic,copy) NSString *quantity;
/**
 *  金额
 */
@property (nonatomic,copy) NSString *amount;
/**
 *  运费
 */
@property (nonatomic,copy) NSString *fee_amount;
/**
 *  商品规格列表
 */
@property (nonatomic,strong) NSArray<TLMyOrderProdSpecList,ConvertOnDemand> *prod_spec_list;


@property (nonatomic,copy) NSString *country_pic_url;

@property (nonatomic,copy) NSString *import_info_desc;

@property (nonatomic,copy) NSString *transfer_fee_desc;

@property (nonatomic,copy) NSString *tariff_desc;

@property (nonatomic,copy) NSString *import_goods_flag;





@end
