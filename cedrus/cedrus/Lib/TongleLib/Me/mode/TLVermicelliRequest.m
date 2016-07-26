//
//  TLVermicelliRequest.m
//  tongle
//
//  Created by jixiaofei-mac on 15-6-26.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLVermicelliRequest.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import "TLCommon.h"

@implementation TLVermicelliRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        TL_USER_TOKEN_REQUEST_1 = [TLPersonalMegTool currentPersonalMeg].token;
        _user_id = [TLPersonalMegTool currentPersonalMeg].user_id;
        _forward = LOADDATA;
        _fetch_count = DownAmount;
    }
    return self;
}

@end
