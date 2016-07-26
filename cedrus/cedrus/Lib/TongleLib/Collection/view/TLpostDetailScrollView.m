//
//  TLpostDetailScrollView.m
//  tongle
//
//  Created by liu ruibin on 15-5-18.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLpostDetailScrollView.h"
#import "TLpostDetailFrame.h"
#import "TLPostDetail.h"
#import "TLPostDetailContent.h"
#import "TLImageName.h"
#import "TLCommon.h"
#import "UIColor+TL.h"
#import "UIImageView+Image.h"



@interface TLpostDetailScrollView ()

//用户昵称
@property (nonatomic,weak) UILabel      *user_nick_name;
//用户签名
@property (nonatomic,weak) UILabel      *user_signature;
//用户头像
@property (nonatomic,weak) UIImageView  *user_head_photo;

//帖子标题
@property (nonatomic,weak) UILabel      *post_title;
//帖子发布时间
@property (nonatomic,weak) UILabel      *post_time;

//帖子封面图
@property (nonatomic,weak) UIImageView  *cover_picture;
//二维码按键
@property (nonatomic,weak) UIButton     *codeButton;

@property (nonatomic,weak) TLPostDetailContent *postDetailContent;

@end

@implementation TLpostDetailScrollView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //帖子封面图
        UIImageView *cover_picture = [[UIImageView alloc]init];
        [self addSubview:cover_picture];
        self.cover_picture = cover_picture;
        //二维码按键
        UIButton *codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //[self addSubview:codeButton];
        self.codeButton = codeButton;
       // [codeButton addTarget:self action:@selector(codeButton:) forControlEvents:UIControlEventTouchUpInside];
        [codeButton setImage:[UIImage imageNamed:TL_QR_CODE_NORMAL ] forState:UIControlStateNormal];
        [codeButton setImage:[UIImage imageNamed:TL_QR_CODE_PRESS ]forState:UIControlStateHighlighted];
        
        //用户头像
        UIImageView *user_head_photo = [[UIImageView alloc]init];
        user_head_photo.userInteractionEnabled = YES;
        UITapGestureRecognizer *gesture_user_head_photo = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(masterGesture:)];
        [user_head_photo addGestureRecognizer:gesture_user_head_photo];
        [self addSubview:user_head_photo];
        self.user_head_photo = user_head_photo;
        //用户昵称
        UILabel *user_nick_name = [[UILabel alloc]init];
        user_nick_name.userInteractionEnabled = YES;
        UITapGestureRecognizer *gesture_user_nick_name = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(masterGesture:)];
        [user_nick_name addGestureRecognizer:gesture_user_nick_name];
        [self addSubview:user_nick_name];
        user_nick_name.font = TLNameFont;
        user_nick_name.backgroundColor = [UIColor clearColor];
        [user_nick_name setTextColor:[UIColor getColor:TL_USER_NAME_COLOR]];
        self.user_nick_name = user_nick_name;
        
        //用户签名
        UILabel *user_signature = [[UILabel alloc]init];
        [self addSubview:user_signature];
        user_signature.font = TLSignaFont;
        self.user_signature = user_signature;
        //帖子标题
        UILabel *post_title = [[UILabel alloc]init];
        post_title.numberOfLines = 2;
        [self addSubview:post_title];
        post_title.font = [UIFont systemFontOfSize:18];
        self.post_title = post_title;
        //帖子发布时间
        UILabel *post_time = [[UILabel alloc]init];
        [self addSubview:post_time];
        post_time.textColor = [UIColor getColor:TL_FIRST_POST_TIME_COLOR];
        post_time.backgroundColor = [UIColor clearColor];
        post_time.font = TLTimeFont;
        self.post_time = post_time;
        
    
    }
    return self;
}


-(void)setPostDetailFrame:(TLpostDetailFrame *)postDetailFrame
{
    _postDetailFrame = postDetailFrame;
    
    TLPostDetail *postDetail = postDetailFrame.postDetail;
    
    self.cover_picture.frame = postDetailFrame.cover_pictureF;
    [self.cover_picture setImageWithURL:postDetail.user_post_info.cover_picture_url placeImage:[UIImage imageNamed:TL_PRODUCT_DEFAULT_IMG]];
    self.post_title.frame = postDetailFrame.post_titleF;
    self.post_title.text = postDetail.user_post_info.first_post_title;
    
    self.codeButton.frame = postDetailFrame.codeF;
    
    self.user_head_photo.frame = postDetailFrame.user_head_photoF;
    [self.user_head_photo setImageWithURL:postDetail.user_post_info.first_user_head_photo_url placeImage:[UIImage imageNamed:TL_AVATAR_DEFAULT]];
    self.user_nick_name.frame = postDetailFrame.user_nick_nameF;
    self.user_nick_name.text = postDetail.user_post_info.first_user_nick_name;
    
    self.post_time.frame = postDetailFrame.post_timeF;
    self.post_time.text = postDetail.user_post_info.first_post_time;
    
    self.user_signature.frame = postDetailFrame.user_signatureF;
    self.user_signature.text = postDetail.user_post_info.first_user_signature;

    
}

-(void)codeButton:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(postDetailScrollView:withcode:)]) {
        [self.delegate postDetailScrollView:self withcode:button];
    }
}

-(void)masterGesture:(UITapGestureRecognizer *)Gesture
{
    if ([self.delegate respondsToSelector:@selector(postDetailScrollView:withGesture:)]) {
        [self.delegate postDetailScrollView:self withGesture:Gesture];
    }
}



@end
