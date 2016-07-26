//
//  TLProdCommentRequest.m
//  tongle
//
//  Created by liu ruibin on 15-5-22.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLProdCommentRequest.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"

@implementation TLProdCommentRequest

-(instancetype)init
{
    if (self = [super init]) {
        _user_id = [TLPersonalMegTool currentPersonalMeg].user_id;
        TL_USER_TOKEN_REQUEST_1 = [TLPersonalMegTool currentPersonalMeg].token;
        _product_id = [[NSUserDefaults standardUserDefaults] objectForKey:TL_PROD_DETAILS_PROD_ID];
        _fetch_count = DownAmount;
        _forward = LOADDATA;
        _rating_doc_no = @"";
        _level = TL_ALL;
    }
    return self;
}

@end
