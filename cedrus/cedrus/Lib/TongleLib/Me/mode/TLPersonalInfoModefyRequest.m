//
//  TLPersonalInfoModefyRequest.m
//  tongle
//
//  Created by jixiaofei-mac on 15-9-29.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLPersonalInfoModefyRequest.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"


@implementation TLPersonalInfoModefyRequest

-(instancetype)init
{
    self = [super init];
    if (self) {
        _user_id = [TLPersonalMegTool currentPersonalMeg].user_id;
        TL_USER_TOKEN_REQUEST_1 = [TLPersonalMegTool currentPersonalMeg].token;
        _user_nick_name = [TLPersonalMegTool currentPersonalMeg].user_nick_name;
    }
    return self;
}

@end
