//
//  TLMaster.h
//  tongle
//
//  Created by liu on 15-4-23.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@protocol TLMasterParam


@end

@interface TLMasterParam : JSONModel

//用户ID
@property (nonatomic, copy)NSString *user_id;
//用户昵称
@property (nonatomic, copy)NSString *user_nick_name;
//用户签名
@property (nonatomic, copy)NSString *user_signature;
//用户头像URL
@property (nonatomic, copy)NSString *user_head_photo_url;
//最近发帖内容
@property (nonatomic, copy)NSString *latest_post_info;
//未读新帖数
@property (nonatomic, copy)NSString *latest_post_count;
//帖子最近更新时间
@property (nonatomic, copy)NSString *post_update_time;
//收藏
@property (nonatomic,copy)NSString *user_favorited_by_me;
//加入时间
@property (nonatomic,copy)NSString *join_time;


@end
