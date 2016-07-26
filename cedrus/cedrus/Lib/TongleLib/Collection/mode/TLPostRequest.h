//
//  TLPostRequest.h
//  tongle
//
//  Created by liu on 15-4-24.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLCommon.h"

@interface TLPostRequest : NSObject

//用户ID（必须指定）
@property (nonatomic,copy) NSString *user_id;
//指定帖子ID（可为空）
@property (nonatomic,copy) NSString *post_id;
//翻页方向（向前翻或向后翻）（可为空）
@property (nonatomic,copy) NSString *forward;
//返回列表条数（必须指定）
@property (nonatomic,copy) NSString *fetch_count;
//token
@property (nonatomic,copy) NSString *TL_USER_TOKEN_REQUEST;

@end
