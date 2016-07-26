//
//  TLShopCarRequest.m
//  tongle
//
//  Created by liu on 15-5-7.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLShopCarRequest.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"

@implementation TLShopCarRequest

-(instancetype)init
{
    if (self = [super init]) {
        _user_id = [TLPersonalMegTool currentPersonalMeg].user_id;
        TL_USER_TOKEN_REQUEST_1 = [TLPersonalMegTool currentPersonalMeg].token;
    }
    return self;
    
}


@end
