//
//  TLGroupCouponsListRequest.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/15.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLCommon.h"


@interface TLGroupCouponsListRequest : NSObject

@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString *order_no;
@property (nonatomic,copy) NSString *out_of_date;
@property (nonatomic,copy) NSString *forward;
@property (nonatomic,copy) NSString *fetch_count;
@property (nonatomic,copy) NSString *TL_USER_TOKEN_REQUEST;

@end