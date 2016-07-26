//
//  TLShopCar.h
//  TL11
//
//  Created by liu on 15-4-15.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
//#import "TLProdSpecList_color_size.h"
#import "TLProdSpecList_size.h"

@protocol  TLShopCar

@end

@interface TLShopCar : JSONModel

//明细序号
@property (nonatomic,copy) NSString *seq_no;
//帖子ID
@property (nonatomic,copy) NSString *post_id;
//商品缩略图URL
@property (nonatomic,copy) NSString *prod_pic_url;
//商品编码
@property (nonatomic,copy) NSString *prod_id;
//商品名称
@property (nonatomic,copy) NSString *prod_name;
//经销商名称
@property (nonatomic,copy) NSString *mstore_name;
//价格
@property (nonatomic,copy) NSString *price;
//数量
@property (nonatomic,copy) NSString *order_qty;
//金额
@property (nonatomic,copy) NSString *amount;
//运费
@property (nonatomic,copy) NSString *fee_amount;
//规格列表
@property (nonatomic,strong) NSArray<TLProdSpecList_size,ConvertOnDemand> *prod_spec_list;//TLProdSpecList_size
//二维码关联id
@property (nonatomic,copy) NSString *relation_id;
//进口国图片
@property (nonatomic,copy) NSString *country_pic_url;
//进口信息描述
@property (nonatomic,copy) NSString *import_info_desc;
//配送费描述
@property (nonatomic,copy) NSString *transfer_fee_desc;
//关税描述
@property (nonatomic,copy) NSString *tariff_desc;
//实际关税
@property (nonatomic,copy) NSString *tariff;
//进口商品标识
@property (nonatomic,copy) NSString *import_goods_flag;
////商品颜色
//@property (nonatomic,strong) TLProdSpecList_color *speclist_color;
////商品尺寸
//@property (nonatomic,strong) TLProdSpecList_size *speclist_size;

@end
