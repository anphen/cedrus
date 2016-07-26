//
//  TLUserPostInfo.h
//  tongle
//
//  Created by liu ruibin on 15-5-15.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLPostContent.h"

@protocol TLUserPostInfo  <NSObject>


@end

@interface TLUserPostInfo : JSONModel

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

@property (nonatomic,strong) NSArray *post_thumbnail_pic_url;

@property (nonatomic,copy) NSString *post_comment;
//帖子发布时间
@property (nonatomic,copy) NSString *post_time;
//帖子是否被当前用户收藏
@property (nonatomic,copy) NSString *post_favorited_by_me;

@property (nonatomic,copy) NSString *first_user_id;
@property (nonatomic,copy) NSString *first_user_nick_name;
@property (nonatomic,copy) NSString *first_user_signature;
@property (nonatomic,copy) NSString *first_user_head_photo_url;
@property (nonatomic,copy) NSString *first_post_id;
@property (nonatomic,copy) NSString *first_post_title;
@property (nonatomic,copy) NSArray  *first_post_thumbnail_pic_url;
@property (nonatomic,copy) NSString *first_post_time;

@property (nonatomic,copy) NSString *post_wx_profile;
@property (nonatomic,copy) NSString *first_wx_profile;

//帖子封面图URL
@property (nonatomic,copy) NSString *cover_picture_url;
//帖子内容详情
@property (nonatomic,strong) NSArray<TLPostContent,ConvertOnDemand> *post_content;


@end