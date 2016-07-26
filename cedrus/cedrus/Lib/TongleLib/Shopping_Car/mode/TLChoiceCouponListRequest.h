//
//  TLChoiceCouponListRequest.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/31.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLCommon.h"

@interface TLChoiceCouponListRequest : NSObject

@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,strong) NSArray *goods_info;
@property (nonatomic,copy) NSString *TL_USER_TOKEN_REQUEST;

@end
