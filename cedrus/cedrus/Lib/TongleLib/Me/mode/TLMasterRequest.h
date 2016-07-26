//
//  TLMasterRequest.h
//  tongle
//
//  Created by liu on 15-4-24.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLCommon.h"
#import "TLImageName.h"

@interface TLMasterRequest : NSObject


//用户ID（必须指定）
@property (nonatomic,copy) NSString *user_id;
//专家会员ID（可为空）
@property (nonatomic,copy) NSString *expert_user_id;
//翻页方向（向前翻或向后翻）（可为空）
@property (nonatomic,copy) NSString *forward;
//返回列表条数（必须指定）
@property (nonatomic,copy) NSString *fetch_count;
//token
@property (nonatomic,copy) NSString *TL_USER_TOKEN_REQUEST;

/**
 *  入口参数"专家会员ID"可以为空，为空时，"翻页方向"只能为向后翻。这种情况应用在首次进入页面或刷新时使用。
 */

@end
