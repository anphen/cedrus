//
//  TLFriendsPostsRequest.m
//  tongle
//
//  Created by liu ruibin on 15-5-6.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLFriendsPostsRequest.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"

@implementation TLFriendsPostsRequest
- (id)init
{
    if (self = [super init]) {
        TL_USER_TOKEN_REQUEST_1 = [TLPersonalMegTool currentPersonalMeg].token;
        _user_id = [TLPersonalMegTool currentPersonalMeg].user_id;
        //初始化帖子个数
        _fetch_count = DownAmount;
        _forward = LOADDATA;
    }
    return self;
}

@end
