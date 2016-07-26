//
//  TLPostTopView.m
//  tongle
//
//  Created by liu on 15-4-27.
//  Copyright (c) 2015年 isoviewtstone. All rights reserved.
//

#import "TLPostTopView.h"
#import "TLPostFrame.h"
#import "TLPostParam.h"
#import "TLPostReweetView.h"
#import "TLPhotoView.h"
#import "TLPhotoListView.h"
#import "TLPhoto.h"
#import "UIImage+TL.h"
#import "TLCommon.h"
#import "TLImageName.h"
#import "UIColor+TL.h"
#import "UIImageView+Image.h"

@interface TLPostTopView ()

//用户昵称
@property (nonatomic,weak) UILabel      *user_nick_label;
//用户签名
@property (nonatomic,weak) UILabel      *user_signature_label;
//用户头像
@property (nonatomic,weak) UIImageView  *user_head_photoview;

//帖子标题
@property (nonatomic,weak) UILabel      *post_title_label;
//帖子转发内容
@property (nonatomic,weak) UILabel      *post_comment_label;
//帖子发布时间
@property (nonatomic,weak) UILabel      *post_time_label;
//帖子图片
@property (nonatomic,weak) TLPhotoListView *post_pic_view;


@property (nonatomic,weak) UIImageView       *division;



@end

@implementation TLPostTopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //self.userInteractionEnabled = YES;
       //1.设置图片
        self.image = [UIImage resizedImage:@"timeline_card_top_background"];
        self.highlightedImage = [UIImage resizedImage:@"timeline_card_top_background_highlighted"];
        //self.backgroundColor = [UIColor greenColor];
        //2.设置头像
        UIImageView *user_head_photoview = [[UIImageView alloc]init];
        user_head_photoview.userInteractionEnabled = YES;
        [self addSubview:user_head_photoview];
        self.user_head_photoview = user_head_photoview;
        
        //增加手势
        UITapGestureRecognizer *singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleRecognizeruserhead)];
         [user_head_photoview addGestureRecognizer:singleRecognizer];
        
        //3.设置用户昵称
        UILabel *user_nick_label = [[UILabel alloc]init];
        user_nick_label.userInteractionEnabled = YES;
        // [user_nick_label addGestureRecognizer:singleRecognizer];
        user_nick_label.font = TLNameFont;
        user_nick_label.backgroundColor = [UIColor clearColor];
        [user_nick_label setTextColor:[UIColor getColor:TL_USER_NAME_COLOR]];
        [self addSubview:user_nick_label];
        self.user_nick_label = user_nick_label;
        
        //增加手势
        UITapGestureRecognizer *nickRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleRecognizeruserhead)];
        [user_nick_label addGestureRecognizer:nickRecognizer];
        
        //4.设置用户签名
        UILabel *user_signature_label = [[UILabel alloc]init];
        user_signature_label.font = TLSignaFont;
        [self addSubview:user_signature_label];
        self.user_signature_label = user_signature_label;
        
        //5.设置帖子标题
        UILabel *post_title_label  = [[UILabel alloc]init];
        post_title_label.font = TLNameFont;
        [self addSubview:post_title_label];
        self.post_title_label = post_title_label;
        
        //6.设置帖子发布时间
        UILabel *post_time_label = [[UILabel alloc]init];
        post_time_label.font = TLTimeFont;
        post_time_label.textColor = [UIColor getColor:TL_FIRST_POST_TIME_COLOR];
        post_time_label.backgroundColor = [UIColor clearColor];
        [self addSubview:post_time_label];
        self.post_time_label = post_time_label;
        
        //7.设置帖子转发内容
        UILabel *post_comment_label = [[UILabel alloc]init];
        post_comment_label.font = TLContentFont;
        post_comment_label.numberOfLines = 0;
        post_comment_label.textColor = [UIColor getColor:TL_TEXT_COLOR];
        post_comment_label.backgroundColor = [UIColor clearColor];
        [self addSubview:post_comment_label];
        self.post_comment_label = post_comment_label;
        
        //8.设置帖子图片

        TLPhotoListView *photoListView = [[TLPhotoListView alloc]init];
        [self addSubview:photoListView];
        self.post_pic_view = photoListView;

        //9.分割线
        UIImageView *division = [[UIImageView alloc]init];
        division.userInteractionEnabled = NO;
        division.image = [UIImage imageNamed:@"space_bk.jpg"];
        [self addSubview:division];
        self.division = division;
       
    }
    return self;
}

-(void)singleRecognizeruserhead
{
    if ([self.delegate respondsToSelector:@selector(postTopViewHeadImage:WithPostFrame:)]) {
        [self.delegate postTopViewHeadImage:self WithPostFrame:_postframe];
    }
}

-(void)setPostframe:(TLPostFrame *)postframe
{
    _postframe = postframe;
    
    //1.取出模型
    TLPostParam *postParam = postframe.postParam;
    //2.头像
    [self.user_head_photoview setImageWithURL:postParam.user_head_photo_url placeImage:[UIImage imageNamed:TL_AVATAR_DEFAULT]];
    self.user_head_photoview.frame = self.postframe.user_head_photoF;
    
    //3.昵称
    self.user_nick_label.text = postParam.user_nick_name;
    self.user_nick_label.frame = self.postframe.user_nick_nameF;
    
    //4.签名

    //self.user_signature_label.text = postParam.user_signature;
    //self.user_signature_label.frame = self.postframe.user_signatureF;

    
    //5.标题
    if (![postParam.post_id isEqualToString:postParam.first_post_id])
    {
        self.post_title_label.text = postParam.first_post_title;
        self.post_title_label.frame = self.postframe.first_post_titleF;
    }else
    {
        self.post_title_label.text = nil;
    }
    
    //6.时间
    self.post_time_label.text = postParam.post_time;
    self.post_time_label.frame = self.postframe.post_timeF;
    
    
    if ([postParam.post_id isEqualToString:postParam.first_post_id])
    {
        self.post_comment_label.text = postParam.first_post_title;
    }else
    {
        self.post_comment_label.text = postParam.post_comment;
    }
    //7.转发内容
    self.post_comment_label.numberOfLines = 0;
    self.post_comment_label.frame = self.postframe.post_commentF;
    //8.配图
    if (postParam.first_post_thumbnail_pic_url.count) {
       // NSDictionary *dict = postParam.post_thumbnail_pic_url[0];
        //if (![dict[@"pic_url"] isEqualToString:@""]) {
            self.post_pic_view.hidden = NO;
            self.post_pic_view.frame = self.postframe.first_post_thumbnail_pic_urlF;
            self.post_pic_view.photoUrls = postParam.first_post_thumbnail_pic_url;
        //}else
        //{
          //  self.post_pic_view.hidden = YES;
        //}
    }else
    {
        self.post_pic_view.hidden = YES;
    }
    self.division.frame = self.postframe.divisionF;
}

@end
