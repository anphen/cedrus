//
//  TLGroupProdBaseInfo.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/10.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLGroupProdSpecList.h"

@protocol TLGroupProdBaseInfo <NSObject>


@end

@interface TLGroupProdBaseInfo : JSONModel

@property (nonatomic,copy)  NSString *prod_id;
@property (nonatomic,copy)  NSString *prod_name;
@property (nonatomic,copy)  NSString *prod_resume;
@property (nonatomic,copy)  NSString *prod_property;
@property (nonatomic,strong)NSArray  *prod_pic_url_list;
@property (nonatomic,copy)  NSString *prod_status;
@property (nonatomic,copy)  NSString *mstore_id;
@property (nonatomic,copy)  NSString *mstore_name;
@property (nonatomic,copy)  NSString *price;
@property (nonatomic,copy)  NSString *show_price;
@property (nonatomic,copy)  NSString *stock_qty;
@property (nonatomic,copy)  NSString *good_rating_percent;
@property (nonatomic,copy)  NSString *good_rating_qty;
@property (nonatomic,copy)  NSString *prod_favorited_by_me;
@property (nonatomic,copy)  NSString *trade_prod_favorited_by_me;
@property (nonatomic,copy)  NSString *post_id;
@property (nonatomic,copy)  NSString *relation_id;
@property (nonatomic,copy)  NSString *sender;
@property (nonatomic,copy)  NSString *point_rule_url;
@property (nonatomic,copy)  NSString *point_rule_title;
@property (nonatomic,copy)  NSString *sold_qty;
@property (nonatomic,copy)  NSString *buy_limit_qty;
@property (nonatomic,strong) NSArray<TLGroupProdSpecList,ConvertOnDemand> *spec_detail_list;

@end
