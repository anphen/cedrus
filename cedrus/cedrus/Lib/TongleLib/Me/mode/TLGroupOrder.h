//
//  TLGroupOrder.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/15.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLGroupOrderPayInfo.h"
#import "TLProdSpecList_size.h"
#import "TLVoucherBase.h"

@protocol TLGroupOrder <NSObject>


@end


@interface TLGroupOrder : JSONModel

@property (nonatomic,copy) NSString *order_no;
@property (nonatomic,copy) NSString *order_qty;
@property (nonatomic,copy) NSString *evaluate_flag;
@property (nonatomic,copy) NSString *order_price;
@property (nonatomic,copy) NSString *order_amount;
@property (nonatomic,copy) NSString *order_create_time;
@property (nonatomic,copy) NSString *unused_qty;
@property (nonatomic,copy) NSString *refund_qty;
@property (nonatomic,copy) NSString *refunding_qty;
@property (nonatomic,copy) NSString *used_qty;
@property (nonatomic,copy) NSString *prod_id;
@property (nonatomic,copy) NSString *prod_name;
@property (nonatomic,copy) NSString *relation_id;
@property (nonatomic,strong) TLVoucherBase *voucher_base;

@property (nonatomic,strong) NSArray *prod_pic_url_list;
@property (nonatomic,strong) TLGroupOrderPayInfo *order_pay_info;
//规格列表
@property (nonatomic,strong) NSArray<TLProdSpecList_size,ConvertOnDemand> *prod_spec_list;


@end
