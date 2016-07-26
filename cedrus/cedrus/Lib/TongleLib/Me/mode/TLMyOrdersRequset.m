//
//  TLMyOrdersRequset.m
//  tongle
//
//  Created by jixiaofei-mac on 15-6-8.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLMyOrdersRequset.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"

@implementation TLMyOrdersRequset

-(instancetype)init
{
    if (self = [super init]) {
        _user_id = [TLPersonalMegTool currentPersonalMeg].user_id;
        TL_USER_TOKEN_REQUEST_1 = [TLPersonalMegTool currentPersonalMeg].token;
        _order_status = @"0";
        _order_date_from = @"";
        _order_date_to = @"";
        _order_no = @"";
        _forward = LOADDATA;
        _fetch_count = DownAmount;
    }
    return self;
}
@end
