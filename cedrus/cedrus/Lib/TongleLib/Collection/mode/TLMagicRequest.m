//
//  TLMagicRequest.m
//  tongle
//
//  Created by liu on 15-4-24.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLMagicRequest.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"

@implementation TLMagicRequest
- (instancetype)init
{
    self = [super init];
    if (self) {
        TL_USER_TOKEN_REQUEST_1 = [TLPersonalMegTool currentPersonalMeg].token;
        _user_id = [TLPersonalMegTool currentPersonalMeg].user_id;
        _mstore_id = @"";
        _forward = LOADDATA;
        _fetch_count = DownAmount;
    }
    return self;
}

@end
