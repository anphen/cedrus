//
//  TLMeRequest.h
//  tongle
//
//  Created by liu on 15-5-4.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLCommon.h"


@interface TLMeRequest : NSObject

//用户ID（必须指定）
@property (nonatomic,copy) NSString *user_id;

//token
@property (nonatomic,copy) NSString *TL_USER_TOKEN_REQUEST;

@end
