//
//  TLMagicRequest.h
//  tongle
//
//  Created by liu on 15-4-24.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLCommon.h"


@interface TLMagicRequest : NSObject

@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString *TL_USER_TOKEN_REQUEST;
@property (nonatomic,copy) NSString *mstore_id;
@property (nonatomic,copy) NSString *forward;
@property (nonatomic,copy) NSString *fetch_count;

@end
