//
//  TLpostDetailFrame.h
//  tongle
//
//  Created by liu ruibin on 15-5-18.
//  assign,readonlyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import <UIKit/UIKit.h>
@class TLPostDetail;


@interface TLpostDetailFrame : JSONModel


@property (nonatomic,strong) TLPostDetail *postDetail;

//用户昵称
@property (nonatomic,assign,readonly) CGRect user_nick_nameF;
//用户签名
@property (nonatomic,assign,readonly) CGRect user_signatureF;
//用户头像
@property (nonatomic,assign,readonly) CGRect user_head_photoF;

//帖子标题
@property (nonatomic,assign,readonly) CGRect post_titleF;
//帖子发布时间
@property (nonatomic,assign,readonly) CGRect post_timeF;

//帖子封面图
@property (nonatomic,assign,readonly) CGRect cover_pictureF;
//帖子图片
@property (nonatomic,assign,readonly) CGRect picF;
//帖子图片说明
@property (nonatomic,assign,readonly) CGRect pic_memoF;


@property (nonatomic,assign,readonly) CGRect postDetailContentF;

@property (nonatomic,assign,readonly) CGRect codeF;

//帖子图片
@property (nonatomic,assign,readonly) CGRect pic;
//帖子图片说明
@property (nonatomic,assign,readonly) CGRect pic_memo;

@property (nonatomic,assign,readonly) CGFloat height;



@end
