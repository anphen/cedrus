//
//  TLProductRequest.m
//  tongle
//
//  Created by liu on 15-5-4.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLProductRequest.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"


@implementation TLProductRequest

- (id)init
{
    if (self = [super init]) {
        TL_USER_TOKEN_REQUEST_1 = [TLPersonalMegTool currentPersonalMeg].token;
        _user_id = [TLPersonalMegTool currentPersonalMeg].user_id;
        _fetch_count = DownAmount;
        _prod_id = @"";
        _forward = LOADDATA;
    }
    return self;
}

@end
