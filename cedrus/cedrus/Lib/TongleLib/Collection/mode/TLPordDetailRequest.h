//
//  TLPordDetailRequest.h
//  tongle
//
//  Created by liu ruibin on 15-5-21.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLCommon.h"
@interface TLPordDetailRequest : NSObject

//用户
@property (nonatomic,copy) NSString *user_id;
//商品id
@property (nonatomic,copy) NSString *product_id;
//帖子
@property (nonatomic,copy) NSString *post_id;
//明细入口
@property (nonatomic,copy) NSString *action;
//魔店
@property (nonatomic,copy) NSString *mstore_id;

@property (nonatomic,copy) NSString *relation_id;
//token
@property (nonatomic,copy) NSString *TL_USER_TOKEN_REQUEST;


@end
