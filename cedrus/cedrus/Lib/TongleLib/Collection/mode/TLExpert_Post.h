//
//  TLExpert_Post.h
//  tongle
//
//  Created by jixiaofei-mac on 15-7-10.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLCommon.h"


@interface TLExpert_Post : JSONModel

@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString *expert_user_id;
@property (nonatomic,copy) NSString *post_id;
@property (nonatomic,copy) NSString *forward;
@property (nonatomic,copy) NSString *fetch_count;
@property (nonatomic,copy) NSString *action;
@property (nonatomic,copy) NSString *TL_USER_TOKEN_REQUEST;

@end
