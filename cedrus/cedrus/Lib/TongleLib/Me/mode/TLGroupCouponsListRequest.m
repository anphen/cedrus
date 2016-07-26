//
//  TLGroupCouponsListRequest.m
//  tongle
//
//  Created by jixiaofei-mac on 16/3/15.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "TLGroupCouponsListRequest.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"


@implementation TLGroupCouponsListRequest

-(instancetype)init
{
    if (self = [super init]) {
        _user_id = [TLPersonalMegTool currentPersonalMeg].user_id;
        TL_USER_TOKEN_REQUEST_1 = [TLPersonalMegTool currentPersonalMeg].token;
        _fetch_count = DownAmount;
        _forward = LOADDATA;
        _order_no = @"";
        _out_of_date = @"";
    }
    return self;
}

@end
