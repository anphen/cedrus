//
//  TLGroupProductDetailRequest.m
//  tongle
//
//  Created by jixiaofei-mac on 16/3/10.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "TLGroupProductDetailRequest.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"

@implementation TLGroupProductDetailRequest

-(instancetype)init
{
    if (self = [super init]) {
        _user_id = [TLPersonalMegTool currentPersonalMeg].user_id;
        TL_USER_TOKEN_REQUEST_1 = [TLPersonalMegTool currentPersonalMeg].token;
        _longitude = [TLUserDefaults objectForKey:TL_LONGITUDE];
        _latitude =  [TLUserDefaults objectForKey:TL_LATITUDE];
    }
    return self;
}

@end
