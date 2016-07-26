//
// TLPayResultRequest.m
//  tongle
//
//  Created by jixiaofei-mac on 15-8-18.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLPayResultRequest.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"

@implementation TLPayResultRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        _user_id = [TLPersonalMegTool currentPersonalMeg].user_id;
        TL_USER_TOKEN_REQUEST_1 = [TLPersonalMegTool currentPersonalMeg].token;
        _order_no = [[NSUserDefaults standardUserDefaults]objectForKey:@"pay_order_no"];
    }
    return self;
}

@end
