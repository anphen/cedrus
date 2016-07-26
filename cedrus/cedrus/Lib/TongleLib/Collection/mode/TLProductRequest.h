//
//  TLProductRequest.h
//  tongle
//
//  Created by liu on 15-5-4.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLCommon.h"


@interface TLProductRequest : NSObject
//用户ID（必须指定）
@property (nonatomic,copy) NSString *user_id;

//token
@property (nonatomic,copy) NSString *TL_USER_TOKEN_REQUEST;
//商品ID（可为空）
@property (nonatomic,copy) NSString *prod_id;
//翻页方向（向前翻或向后翻）（可为空）
@property (nonatomic,copy) NSString *forward;
//返回条数（可为空）
@property (nonatomic,copy) NSString *fetch_count;




@end
