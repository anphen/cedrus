//
//  TLPordDetailRequest.m
//  tongle
//
//  Created by liu ruibin on 15-5-21.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLPordDetailRequest.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"


@implementation TLPordDetailRequest

-(instancetype)init
{
    if (self = [super init]) {
        _user_id = [TLPersonalMegTool currentPersonalMeg].user_id;
        TL_USER_TOKEN_REQUEST_1 = [TLPersonalMegTool currentPersonalMeg].token;
        _post_id = @"";
        _mstore_id = @"";
        _relation_id = @"";
    }
    return self;
}

@end