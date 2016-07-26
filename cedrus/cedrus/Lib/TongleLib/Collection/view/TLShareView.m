//
//  TLShareView.m
//  tongle
//
//  Created by liu ruibin on 15-5-19.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLShareView.h"
#import "TLPersonalMeg.h"
#import "TLPersonalMegTool.h"
#import <ShareSDK/ShareSDK.h>
#import "TLImageName.h"
#import "TLCommon.h"
#import "Url.h"
#import "MBProgressHUD+MJ.h"
#import "TLHttpTool.h"
#import "TLPostShare.h"
#import "TLProdShare.h"

@interface TLShareView ()

@property (weak, nonatomic) IBOutlet UITextView *Comment;

@property (weak, nonatomic) IBOutlet UIButton *wechat;

@property (weak, nonatomic) IBOutlet UIButton *friends;

@property (weak, nonatomic) IBOutlet UIButton *weixin;

@property (weak, nonatomic) IBOutlet UIButton *tongle;


@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;



- (IBAction)wechatBtn:(UIButton *)sender;

- (IBAction)friendsBtn:(UIButton *)sender;

- (IBAction)weixinBtn:(UIButton *)sender;

- (IBAction)tongleBtn:(UIButton *)sender;

- (IBAction)cancelBtn:(UIButton *)sender;

@end

@implementation TLShareView


+(instancetype)share
{
    return [[NSBundle mainBundle] loadNibNamed:@"TLShareView" owner:nil options:nil][0];
}

-(void)awakeFromNib
{
    [self textChange];
    [self setupBtn:_wechat icon_normal:TL_WECHAT_NORMAL icon_press:TL_WECHAT_PRESS];
    [self setupBtn:_friends icon_normal:TL_FRIENDS_NORMAL icon_press:TL_FRIENDS_PRESS];
    [self setupBtn:_weixin icon_normal:TL_WEIBO_NORMAL icon_press:TL_WEIBO_PRESS];
    self.weixin.enabled = NO;
    [self setupBtn:_tongle icon_normal:TL_TONGLE_NORMAL icon_press:TL_TONGLE_PRESS];
    _height = CGRectGetMaxY(self.cancelBtn.frame);
    
    self.wechat.tag = 1;
    self.friends.tag = 2;
    self.weixin.tag = 3;
    //self.sss = _Comment;
    
}

-(void)setProd_relation_id:(NSString *)prod_relation_id
{
    _prod_relation_id = prod_relation_id;
}


-(void)textChange
{
   
    
}

-(void)setupBtn:(UIButton *)btn icon_normal:(NSString *)icon_normal icon_press:(NSString *)icon_press
{
    [btn setImage:[UIImage imageNamed:icon_normal] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:icon_press] forState:UIControlStateHighlighted];
}




- (IBAction)wechatBtn:(UIButton *)sender {
    [self shareWithRepost_type:TL_WEIXIN withButton:sender];
    
}

- (IBAction)friendsBtn:(UIButton *)sender {
    [self shareWithRepost_type:TL_WEIXIN withButton:sender];
}

- (IBAction)weixinBtn:(UIButton *)sender {
    
    [self shareWithRepost_type:TL_WEIBO withButton:sender];
}

-(void)shareWithRepost_type:(NSString *)repost_type withButton:(UIButton *)btn
{
    /**
     *  转发帖子
     */
    __unsafe_unretained __typeof(self) weakself = self;
    if ([self.type_post_prod isEqualToString:@"帖子转发"]) {
        NSString *url = [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,repost_Url];
        
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:[TLPersonalMegTool currentPersonalMeg].user_id,@"user_id",self.parent_post_id,@"parent_post_id",self.Comment.text,@"message",repost_type,@"repost_type",[TLPersonalMegTool currentPersonalMeg].token,TL_USER_TOKEN, nil];
        [TLHttpTool postWithURL:url params:param success:^(id json) {
            if (weakself.superview) {
                TLPostShare *postShare = [[TLPostShare alloc]initWithDictionary:json[@"body"] error:nil];
                [self shareWithtype:[self shareRepost_type:btn] linkUrl:postShare.post_link_url  imageUrl:postShare.post_image_url title:postShare.magazine_title description:postShare.wx_profile];
            }
        } failure:nil];
        
    }else
    {
        /**
         *  转发商品
         */
        NSString *url = [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,prod_repost_Url];
        
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:[TLPersonalMegTool currentPersonalMeg].user_id,@"user_id",self.product_id,@"product_id",self.Comment.text,@"message",repost_type,@"repost_type",self.prod_relation_id,@"relation_id",[TLPersonalMegTool currentPersonalMeg].token,TL_USER_TOKEN, nil];
        [TLHttpTool postWithURL:url params:param success:^(id json) {
            if (weakself.superview) {
            TLProdShare *prodShare = [[TLProdShare alloc]initWithDictionary:json[@"body"] error:nil];
           
            [self shareWithtype:[self shareRepost_type:btn] linkUrl:prodShare.prod_link_url imageUrl:prodShare.prod_image_url title:prodShare.magazine_title description:prodShare.wx_profile];
            }
        } failure:nil];
    }

}

-(SSDKPlatformType)shareRepost_type:(UIButton *)btn
{
    switch (btn.tag)
    {
        case 1:
            return SSDKPlatformSubTypeWechatSession;
            break;
        case 2:
            return SSDKPlatformSubTypeWechatTimeline;
            break;
        case 3:
            return SSDKPlatformTypeSinaWeibo;
            break;
        default:
            return 0;
            break;
    }
}


-(void)shareWithtype:(SSDKPlatformType)type linkUrl:(NSString *)linkUrl imageUrl:(NSString *)imageUrl title:(NSString *)title description:(NSString *)description
{
    NSString *commentText = [NSString string];
    if (title.length) {
        commentText = title;
    }else
    {
        commentText = @"通乐";
    }
    UIImage *shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    NSArray* imageArray = @[shareImage];
    if (imageArray)
    {
        [shareParams SSDKSetupShareParamsByText:description
                                         images:imageArray
                                            url:[NSURL URLWithString:linkUrl]
                                          title:commentText
                                           type:SSDKContentTypeImage];
    }
    
    [ShareSDK share:type parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        
        switch (state) {
            case SSDKResponseStateSuccess:
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                    message:nil
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
                break;
            }
            case SSDKResponseStateFail:
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                    message:[NSString stringWithFormat:@"%@", error]
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
                break;
            }
            case SSDKResponseStateCancel:
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                                    message:nil
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
                break;
            }
            default:
                break;
        }

        
    }];
    
//    id<ISSContent> publishContent = [ShareSDK content:description
//                                       defaultContent:nil
//                                                image:[ShareSDK jpegImageWithImage:shareImage quality:1]
//                                                title:commentText
//                                                  url:linkUrl
//                                          description:nil
//                                            mediaType:SSPublishContentMediaTypeNews];
    
    
//    [ShareSDK shareContent:publishContent type:type authOptions:nil shareOptions:[ShareSDK defaultShareOptionsWithTitle:nil                                                                                                                      oneKeyShareList:[NSArray defaultOneKeyShareList]                                                                                                                       qqButtonHidden:NO
//                                                                                                            wxSessionButtonHidden:NO
//                                                                                                               wxTimelineButtonHidden:NO
//                                                                                                                 showKeyboardOnAppear:NO
//                                                                                                                    shareViewDelegate:nil
//                                                                                                                  friendsViewDelegate:nil
//                                                                                                                picViewerViewDelegate:nil] statusBarTips:YES targets:nil result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//        if (state == SSPublishContentStateSuccess)
//        {
//            [ShareSDK cancelAuthWithType:type];
//            [MBProgressHUD showSuccess:TL_SHARE_SUCCESS];
//            
//        }
//        else if (state == SSPublishContentStateFail)
//        {
//            if (type == ShareTypeWeixiSession || type == ShareTypeWeixiTimeline) {
//                [MBProgressHUD showSuccess:TL_WEIXING_SHARE_FAIL];
//            }else
//            {
//                [MBProgressHUD showSuccess:TL_SHARE_FAIL];
//
//            }
//        }
//        
//    }];
    [self cancelBtn:nil];

}

- (IBAction)tongleBtn:(UIButton *)sender {
    
    __unsafe_unretained __typeof(self) weakself = self;
    /**
     *  站内转发帖子
     */
    if ([self.type_post_prod isEqualToString:@"帖子转发"]) {
        NSString *url = [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,repost_Url];
        
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:[TLPersonalMegTool currentPersonalMeg].user_id,@"user_id",self.parent_post_id,@"parent_post_id",self.Comment.text,@"message",TL_TONGLE,@"repost_type",[TLPersonalMegTool currentPersonalMeg].token,TL_USER_TOKEN, nil];
        [TLHttpTool postWithURL:url params:param success:^(id json) {
            if (weakself.superview) {
                [MBProgressHUD showSuccess:TL_SHARE_SUCCESS];
                [weakself cancelBtn:nil];
            }
        } failure:^(NSError *error) {
            if (weakself.superview) {
               // [MBProgressHUD showSuccess:TL_SHARE_FAIL];
                [weakself cancelBtn:nil];
            }
        }];
    }else
    {
        /**
         *  站内转发商品
         */
        NSString *url = [NSString stringWithFormat:@"%@%@%@",Url,[TLPersonalMegTool currentPersonalMeg].token,prod_repost_Url];
        
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:[TLPersonalMegTool currentPersonalMeg].user_id,@"user_id",self.product_id,@"product_id",self.Comment.text,@"message",TL_TONGLE,@"repost_type",self.prod_relation_id,@"relation_id",[TLPersonalMegTool currentPersonalMeg].token,TL_USER_TOKEN, nil];
        [TLHttpTool postWithURL:url params:param success:^(id json) {
            if (weakself.superview) {
                [MBProgressHUD showSuccess:TL_SHARE_SUCCESS];
                [weakself cancelBtn:nil];
            }
        } failure:^(NSError *error) {
            if (weakself.superview) {
               // [MBProgressHUD showSuccess:TL_SHARE_FAIL];
                [weakself cancelBtn:nil];
            }
        }];
    }
}


- (IBAction)cancelBtn:(UIButton *)sender {
    [self.delegate TLShareViewCanelButton];
}
@end
