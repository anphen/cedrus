//
//  TLPostFrame.h
//  tongle
//
//  Created by liu on 15-4-25.
//  assign,readonlyright (c) 2015年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class TLPostParam;

@interface TLPostFrame : NSObject

//用户昵称
@property (nonatomic,assign,readonly) CGRect user_nick_nameF;
//用户签名
@property (nonatomic,assign,readonly) CGRect user_signatureF;
//用户头像
@property (nonatomic,assign,readonly) CGRect user_head_photoF;

//帖子标题
@property (nonatomic,assign,readonly) CGRect post_titleF;
//帖子转发内容
@property (nonatomic,assign,readonly) CGRect post_commentF;
//帖子发布时间
@property (nonatomic,assign,readonly) CGRect post_timeF;
//帖子缩略图片列表
@property (nonatomic,assign,readonly) CGRect post_thumbnail_pic_urlF;

// 顶部的view
@property (nonatomic, assign, readonly) CGRect topViewF;


//原帖会员昵称
@property (nonatomic,assign,readonly) CGRect first_user_nick_nameF;
//原帖会员签名
@property (nonatomic,assign,readonly) CGRect first_user_signatureF;
//原帖头像
@property (nonatomic,assign,readonly) CGRect first_user_head_photoF;

//原帖帖子标题
@property (nonatomic,assign,readonly) CGRect first_post_titleF;
//原帖缩略图片列表
@property (nonatomic,assign,readonly) CGRect first_post_thumbnail_pic_urlF;
//原帖发布时间
@property (nonatomic,assign,readonly) CGRect first_post_timeF;


/** 转发帖子的整体 */
@property (nonatomic, assign, readonly) CGRect first_postViewF;

@property (nonatomic,assign,readonly) CGRect divisionF;

/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;


/** 模型 */
@property (nonatomic, strong) TLPostParam *postParam;


@end
