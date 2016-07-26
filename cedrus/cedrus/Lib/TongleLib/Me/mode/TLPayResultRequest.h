//
//  TLPayRequest.h
//  tongle
//
//  Created by jixiaofei-mac on 15-8-18.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLCommon.h"


@interface TLPayResultRequest : NSObject

@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString *order_no;
@property (nonatomic,copy) NSString *TL_USER_TOKEN_REQUEST;

@end
 