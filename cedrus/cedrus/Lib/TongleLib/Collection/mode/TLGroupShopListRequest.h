//
//  TLGroupShopListRequest.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/9.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLCommon.h"


@interface TLGroupShopListRequest : NSObject



@property (nonatomic,copy) NSString *user_id;

@property (nonatomic,copy) NSString *product_id;

@property (nonatomic,copy) NSString *code;

@property (nonatomic,copy) NSString *forward;

@property (nonatomic,copy) NSString *fetch_count;

@property (nonatomic,copy) NSString *longitude;

@property (nonatomic,copy) NSString *latitude;

@property (nonatomic,copy) NSString *TL_USER_TOKEN_REQUEST;


@end
