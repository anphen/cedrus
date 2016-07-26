//
//  TLShopCreateRequest.h
//  tongle
//
//  Created by jixiaofei-mac on 15-7-6.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLCommon.h"


@interface TLShopCreateRequest : NSObject

@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString *post_id;
@property (nonatomic,copy) NSString *product_info_json;
@property (nonatomic,copy) NSString *wifi_id;
@property (nonatomic,copy) NSString *mstore_id;
@property (nonatomic,copy) NSString *realtion_id;
@property (nonatomic,copy) NSString *TL_USER_TOKEN_REQUEST;

@end
