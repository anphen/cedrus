//
//  TLGroupOrderCreateRequest.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/15.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLProdSpecList_size.h"
#import "TLCommon.h"


@interface TLGroupOrderCreateRequest : NSObject

@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString *product_id;
@property (nonatomic,copy) NSString *order_qty;

@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *amount;
@property (nonatomic,copy) NSString *vouchers_number_id;
@property (nonatomic,strong) NSArray *prod_spec_list;

@property (nonatomic,copy) NSString *relation_id;
@property (nonatomic,copy) NSString *mstore_id;
@property (nonatomic,copy) NSString *post_id;
@property (nonatomic,copy) NSString *order_no;
@property (nonatomic,copy) NSString *order_amount;
@property (nonatomic,copy) NSString *TL_USER_TOKEN_REQUEST;


@end
