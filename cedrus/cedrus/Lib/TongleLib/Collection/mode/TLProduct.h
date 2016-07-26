//
//  TLProduct.h
//  TL11
//
//  Created by liu on 15-4-15.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@protocol TLProduct


@end

@interface TLProduct : JSONModel

/**
 *  商品ID
 */
@property (nonatomic,copy) NSString *prod_id;
/**
 *  商品名称
 */
@property (nonatomic,copy) NSString *prod_name;
/**
 *  商品缩略图URL
 */
@property (nonatomic,copy) NSString *prod_thumbnail_pic_url;
/**
 *  价格
 */
@property (nonatomic,copy) NSString *prod_price;
/**
 *  返利规则说明
 */
@property (nonatomic,copy) NSString *prod_points_rule;
/**
 *  关联帖子ID
 */
@property (nonatomic,copy) NSString *post_id;

/**
 *  魔店ID
 */
@property (nonatomic,copy) NSString *mstore_id;

@property (nonatomic,copy) NSString *prod_favorited_by_me;

@property (nonatomic,copy) NSString *trade_prod_favorited_by_me;

@property (nonatomic,copy) NSString *relation_id;

@property (nonatomic,copy) NSString *coupon_flag;

//@property (nonatomic,copy) NSString *country_pic_url;
//
//@property (nonatomic,copy) NSString *import_info_desc;
//
//@property (nonatomic,copy) NSString *transfer_fee_desc;
//
//@property (nonatomic,copy) NSString *tariff_desc;
//
//@property (nonatomic,copy) NSString *import_goods_flag;


@end
