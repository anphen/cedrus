//
//  TLGroupShopListRequest.m
//  tongle
//
//  Created by jixiaofei-mac on 16/3/9.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "TLGroupShopListRequest.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"


@implementation TLGroupShopListRequest

-(instancetype)init
{
    if (self = [super init]) {
        _user_id = [TLPersonalMegTool currentPersonalMeg].user_id;
        TL_USER_TOKEN_REQUEST_1 = [TLPersonalMegTool currentPersonalMeg].token;
        _fetch_count = DownAmount;
        _code = @"";
        _forward = LOADDATA;
        _longitude = [TLUserDefaults objectForKey:TL_LONGITUDE];
        _latitude =  [TLUserDefaults objectForKey:TL_LATITUDE];
    }
    return self;
}


@end
