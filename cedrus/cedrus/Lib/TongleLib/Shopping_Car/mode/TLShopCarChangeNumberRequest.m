//
//  TLShopCarChangeNumberRequest.m
//  tongle
//
//  Created by jixiaofei-mac on 16/1/13.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "TLShopCarChangeNumberRequest.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"

@implementation TLShopCarChangeNumberRequest

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
