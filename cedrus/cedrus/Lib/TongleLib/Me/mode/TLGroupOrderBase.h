//
//  TLGroupOrderBase.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/15.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLProdSpecList_size.h"
#import "TLGroupOrderPayInfo.h"
#import "TLVoucherBase.h"

@protocol TLGroupOrderBase <NSObject>


@end


@interface TLGroupOrderBase : JSONModel

@property (nonatomic,copy) NSString *order_no;
@property (nonatomic,copy) NSString *evaluate_flag;
@property (nonatomic,copy) NSString *order_create_time;
@property (nonatomic,copy) NSString *order_price;
@property (nonatomic,copy) NSString *prod_id;
@property (nonatomic,copy) NSString *prod_name;
@property (nonatomic,strong) NSArray *prod_pic_url_list;
   // @property (nonatomic,copy) NSString *pic_url;
@property (nonatomic,copy) NSString *order_qty;
@property (nonatomic,copy) NSString *order_amount;
   // @property (nonatomic,copy) NSString *vouchers_number_id;
@property (nonatomic,copy) NSString *relation_id;
//规格列表
@property (nonatomic,strong) NSArray<TLProdSpecList_size,ConvertOnDemand> *prod_spec_list;
//    @property (nonatomic,copy) NSString *unused_qty;
//    @property (nonatomic,copy) NSString *refund_qty;
//    @property (nonatomic,copy) NSString *used_qty;
@property (nonatomic,strong) TLGroupOrderPayInfo *order_pay_info;
@property (nonatomic,strong) TLVoucherBase *voucher_base;



@end
