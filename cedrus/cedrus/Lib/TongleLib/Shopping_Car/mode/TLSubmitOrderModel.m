//
//  TLSubmitOrderModel.m
//  tongle
//
//  Created by jixiaofei-mac on 15-10-30.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLSubmitOrderModel.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"

@implementation TLSubmitOrderModel

-(instancetype)init
{
    self = [super init];
    if (self) {
        _user_id = [TLPersonalMegTool currentPersonalMeg].user_id;
        TL_USER_TOKEN_REQUEST_1 = [TLPersonalMegTool currentPersonalMeg].token;
    }
    return self;
}

@end
