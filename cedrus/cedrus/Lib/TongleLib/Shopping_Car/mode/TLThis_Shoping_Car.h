//
//  TLThis_Shoping_Car.h
//  tongle
//
//  Created by jixiaofei-mac on 15-7-8.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLProdSpecList_size.h"

@protocol TLThis_Shoping_Car <NSObject>


@end

@interface TLThis_Shoping_Car : JSONModel

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
@property (nonatomic,strong) NSArray<TLProdSpecList_size,ConvertOnDemand> *prod_spec_list;

@property (nonatomic,copy) NSString *relation_id;

@end
