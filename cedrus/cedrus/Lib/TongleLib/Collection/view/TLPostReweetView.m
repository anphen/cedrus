//
//  TLPostReweet.m
//  tongle
//
//  Created by liu on 15-4-27.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLPostReweetView.h"
#import "TLPostFrame.h"
#import "TLPostParam.h"
#import "TLPhotoView.h"
#import "TLPhoto.h"
#import "TLPhotoListView.h"
#import "TLImageName.h"
#import "TLCommon.h"
#import "UIColor+TL.h"
#import "UIImageView+Image.h"

@interface TLPostReweetView ()


//原帖会员昵称
@property (nonatomic,weak) UILabel      *first_user_nick_label;
//原帖会员签名
@property (nonatomic,weak) UILabel      *first_user_signature_label;
//原帖头像
@property (nonatomic,weak) UIImageView  *first_user_head_photo_view;

//原帖帖子标题
@property (nonatomic,weak) UILabel      *first_post_title_label;
//原帖缩略图片列表
@property (nonatomic,weak) TLPhotoListView *first_post_pic_view;
//原帖发布时间
@property (nonatomic,weak) UILabel      *first_post_time_label;




@end

@implementation TLPostReweetView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
       // self.userInteractionEnabled = YES;

        
        //1.设置图片
        self.image = [UIImage imageNamed:TL_TIMELINE_RETWEET_BACKGROUND];
        
        //2.设置原创头像
        UIImageView *first_user_head_photo_view = [[UIImageView alloc]init];
        [self addSubview:first_user_head_photo_view];
        self.first_user_head_photo_view = first_user_head_photo_view;
        
        //3.设置原创用户昵称
        UILabel *first_user_nick_label = [[UILabel alloc]init];
        first_user_nick_label.font = TLNameFont;
        first_user_nick_label.textColor = TL_FIRST_POST_NAME_COLOR;
        first_user_nick_label.backgroundColor = [UIColor clearColor];
        [self addSubview:first_user_nick_label];
        self.first_user_nick_label = first_user_nick_label;
        
        //4.设置原创用户签名
        UILabel *first_user_signature_label = [[UILabel alloc]init];
        first_user_signature_label.font = TLSignaFont;
        [self addSubview:first_user_signature_label];
        self.first_user_signature_label = first_user_signature_label;
        
        //5.设置原创帖子发布时间
        UILabel *first_post_time_label = [[UILabel alloc]init];
        first_post_time_label.font = TLTimeFont;
        first_post_time_label.backgroundColor = [UIColor clearColor];
        first_post_time_label.textColor = [UIColor getColor:TL_FIRST_POST_TIME_COLOR];
        [self addSubview:first_post_time_label];
        self.first_post_time_label = first_post_time_label;
        
        //7.设置原创帖子内容
        UILabel *first_post_title_label = [[UILabel alloc]init];
        first_post_title_label.font = TLContentFont;
        first_post_title_label.numberOfLines = 0;
        first_post_title_label.textColor = TL_FIRST_POST_TITLE_COLOR;
        first_post_title_label.backgroundColor = [UIColor clearColor];
        [self addSubview:first_post_title_label];
        self.first_post_title_label = first_post_title_label;
        
        //8.设置原创帖子图片
        TLPhotoListView *first_post_pic_view = [[TLPhotoListView alloc]init];
        [self addSubview:first_post_pic_view];
        self.first_post_pic_view = first_post_pic_view;
        
        
    }
    return self;
}

-(void)setPostframe:(TLPostFrame *)postframe
{
    _postframe = postframe;
    
    //1.取出模型
    TLPostParam *postParam = postframe.postParam;
    
    //2.头像
    
    [self.first_user_head_photo_view setImageWithURL:postParam.first_user_head_photo_url placeImage:[UIImage imageNamed:TL_AVATAR_DEFAULT]];
    self.first_user_head_photo_view.frame = self.postframe.first_user_head_photoF;
    
    //3.昵称
    self.first_user_nick_label.text = postParam.first_user_nick_name;
    self.first_user_nick_label.frame = self.postframe.first_user_nick_nameF;
    
    //4.签名
    self.first_user_signature_label.text = postParam.first_user_signature;
    self.first_user_signature_label.frame = self.postframe.first_user_signatureF;
    
    //5.时间
    self.first_post_time_label.text = postParam.first_post_time;
    self.first_post_time_label.frame = self.postframe.first_post_timeF;
    
    //6.标题
    self.first_post_title_label.text = postParam.first_post_title;
    self.first_post_title_label.frame = self.postframe.first_post_titleF;
    
    //7.配图
    if (postParam.first_post_thumbnail_pic_url.count) {
        self.first_post_pic_view.hidden = NO;
        self.first_post_pic_view.frame = self.postframe.first_post_thumbnail_pic_urlF;
        self.first_post_pic_view.photoUrls = postParam.first_post_thumbnail_pic_url;
    }else
    {
        self.first_post_pic_view.hidden = YES;
    }


}



@end
