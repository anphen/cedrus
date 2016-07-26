//
//  TLMasterRequest.m
//  tongle
//
//  Created by liu on 15-4-24.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLMasterRequest.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"

@implementation TLMasterRequest

- (id)init
{
    if (self = [super init]) {
        TL_USER_TOKEN_REQUEST_1 = [TLPersonalMegTool currentPersonalMeg].token;
        _user_id = [TLPersonalMegTool currentPersonalMeg].user_id;
        _expert_user_id = @"";
        _forward = LOADDATA;
        _fetch_count = DownAmount;
    }
    return self;
}


@end
