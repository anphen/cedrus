//
//  TLPost.h
//  tongle
//
//  Created by liu on 15-4-23.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@protocol TLPostParam

@end


@interface TLPostParam : JSONModel

//用户ID
@property (nonatomic,copy) NSString *user_id;
//用户昵称
@property (nonatomic,copy) NSString *user_nick_name;
//用户签名
@property (nonatomic,copy) NSString *user_signature;
//用户头像URL
@property (nonatomic,copy) NSString *user_head_photo_url;

@property (nonatomic,copy) NSString *user_favorited_by_me;
//帖子ID
@property (nonatomic,copy) NSString *post_id;
//帖子标题
@property (nonatomic,copy) NSString *post_title;
//帖子转发内容
@property (nonatomic,copy) NSString *post_comment;
//帖子发布时间
@property (nonatomic,copy) NSString *post_time;
//帖子缩略图片列表
@property (nonatomic,strong) NSArray *post_thumbnail_pic_url;
//是否被当前用户收藏
@property (nonatomic,copy) NSString *post_favorited_by_me;
//原帖会员ID
@property (nonatomic,copy) NSString *first_user_id;
//原帖会员昵称
@property (nonatomic,copy) NSString *first_user_nick_name;
//原帖会员签名
@property (nonatomic,copy) NSString *first_user_signature;
//原帖会员头像URL
@property (nonatomic,copy) NSString *first_user_head_photo_url;
//原帖帖子ID
@property (nonatomic,copy) NSString *first_post_id;
//原帖帖子标题
@property (nonatomic,copy) NSString *first_post_title;
//原帖缩略图片列表
@property (nonatomic,strong) NSArray *first_post_thumbnail_pic_url;
//原帖发布时间
@property (nonatomic,copy) NSString *first_post_time;


@end
