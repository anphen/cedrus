//
//  TLGroupProdBaseInfo.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/15.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"

@interface TLGroupOrderProdBaseInfo : JSONModel


@property (nonatomic,copy) NSString *prod_id;
@property (nonatomic,copy) NSString *prod_name;
@property (nonatomic,copy) NSString *prod_resume;
@property (nonatomic,copy) NSString *prod_property;
@property (nonatomic,strong) NSArray *prod_pic_url_list;
@property (nonatomic,copy) NSString *out_of_date;
@property (nonatomic,copy) NSString *coupon_code;
@property (nonatomic,copy) NSString *expired_date;
@property (nonatomic,copy) NSString *relation_id;
@property (nonatomic,copy) NSString *refund_qty;
@property (nonatomic,copy) NSString *goods_return_url;
@property (nonatomic,copy) NSString *goods_return_title;
@end
