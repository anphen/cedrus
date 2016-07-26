//
//  TLShopCarChangeNumberRequest.h
//  tongle
//
//  Created by jixiaofei-mac on 16/1/13.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLCommon.h"


@interface TLShopCarChangeNumberRequest : NSObject

@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString *seq_no;
@property (nonatomic,copy) NSString *product_id;
@property (nonatomic,copy) NSString *order_qty;
@property (nonatomic,copy) NSString *TL_USER_TOKEN_REQUEST;

@end
