//
//  TLExpert_Post.m
//  tongle
//
//  Created by jixiaofei-mac on 15-7-10.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLExpert_Post.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"

@implementation TLExpert_Post

-(instancetype)init
{
    if (self = [super init]) {
        _user_id = [TLPersonalMegTool currentPersonalMeg].user_id;
        TL_USER_TOKEN_REQUEST_1 = [TLPersonalMegTool currentPersonalMeg].token;
        _fetch_count = DownAmount;
        _action = [[NSUserDefaults standardUserDefaults]objectForKey:TL_ACTION];
        _forward = LOADDATA;
    }
    return self;
}

@end
