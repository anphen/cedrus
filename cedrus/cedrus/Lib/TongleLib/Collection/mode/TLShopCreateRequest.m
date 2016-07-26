//
//  TLShopCreateRequest.m
//  tongle
//
//  Created by jixiaofei-mac on 15-7-6.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLShopCreateRequest.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"

@implementation TLShopCreateRequest


- (id)init
{
    if (self = [super init]) {
        TL_USER_TOKEN_REQUEST_1 = [TLPersonalMegTool currentPersonalMeg].token;
        _user_id = [TLPersonalMegTool currentPersonalMeg].user_id;
    }
    return self;
}

@end
