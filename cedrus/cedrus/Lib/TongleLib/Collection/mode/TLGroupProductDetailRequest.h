//
//  TLGroupProductDetailRequest.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/10.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLCommon.h"


@interface TLGroupProductDetailRequest : NSObject

@property (nonatomic,copy) NSString *user_id;

@property (nonatomic,copy) NSString *product_id;

@property (nonatomic,copy) NSString *post_id;

@property (nonatomic,copy) NSString *action;

@property (nonatomic,copy) NSString *mstore_id;

@property (nonatomic,copy) NSString *relation_id;

@property (nonatomic,copy) NSString *longitude;

@property (nonatomic,copy) NSString *latitude;

@property (nonatomic,copy) NSString *TL_USER_TOKEN_REQUEST;


@end
