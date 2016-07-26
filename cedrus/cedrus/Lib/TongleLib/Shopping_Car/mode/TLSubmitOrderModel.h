//
//  TLSubmitOrderModel.h
//  tongle
//
//  Created by jixiaofei-mac on 15-10-30.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLSubmitOrderModelProd.h"
#import "TLCommon.h"


@interface TLSubmitOrderModel : NSObject

@property (nonatomic,copy)   NSString *user_id;
@property (nonatomic,strong) NSString *product_info_json;
@property (nonatomic,copy)   NSString *TL_USER_TOKEN_REQUEST;

@end
