//
//  TLProdDetails.h
//  tongle
//
//  Created by liu ruibin on 15-5-20.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLProdSpecList.h"
#import "TLStock_List.h"


@protocol TLProdDetails <NSObject>


@end


@interface TLProdDetails : JSONModel
//商品ID
@property (nonatomic,copy) NSString *prod_id;
//商品名称
@property (nonatomic,copy) NSString *prod_name;
//商品简述
@property (nonatomic,copy) NSString *prod_resume;
//商品图片URL列表
@property (nonatomic,strong) NSArray *prod_pic_url_list;
//商品状态
@property (nonatomic,copy) NSString *prod_status;
//魔店ID
@property (nonatomic,copy) NSString *mstore_id;
//魔店名称
@property (nonatomic,copy) NSString *mstore_name;
//价格
@property (nonatomic,copy) NSString *price;
//库存数量
@property (nonatomic,copy) NSString *stock_qty;
//商品好评度
@property (nonatomic,copy) NSString *good_rating_percent;
//适用积分规则
@property (nonatomic,copy) NSString *points_rule;
//是否被当前用户收藏
@property (nonatomic,copy) NSString *prod_favorited_by_me;
//是否被当前用户收藏为宝贝
@property (nonatomic,copy) NSString *trade_prod_favorited_by_me;
//规格列表
@property (nonatomic,strong) NSArray<TLProdSpecList,ConvertOnDemand> *prod_spec_list;

@property (nonatomic,copy) NSString *relation_id;

@property (nonatomic,copy) NSString *country_pic_url;

@property (nonatomic,copy) NSString *import_info_desc;

@property (nonatomic,copy) NSString *transfer_fee_desc;

@property (nonatomic,copy) NSString *tariff_desc;

@property (nonatomic,copy) NSString *import_goods_flag;

//发货方
@property (nonatomic,copy) NSString *sender;
//退换货信息
@property (nonatomic,copy) NSString *goods_return_info;
//积分规则URL
@property (nonatomic,copy) NSString *point_rule_url;
//积分规则Title
@property (nonatomic,copy) NSString *point_rule_title;


@property (nonatomic,strong) NSArray<TLStock_List,ConvertOnDemand> *stock_list;

@property (nonatomic,copy) NSString *price_interval;

@property (nonatomic,copy) NSString *wx_profile;

@end
