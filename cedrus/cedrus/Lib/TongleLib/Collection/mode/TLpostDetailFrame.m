//
//  TLpostDetailFrame.m
//  tongle
//
//  Created by liu ruibin on 15-5-18.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "TLpostDetailFrame.h"
#import "TLPostDetail.h"
#import "TLCommon.h"


@implementation TLpostDetailFrame

-(void)setPostDetail:(TLPostDetail *)postDetail
{
    _postDetail = postDetail;
    
    //帖子封面图
    CGFloat cover_pictureX = 0;
    CGFloat cover_pictureY = 0;
    CGFloat cover_pictureW = ScreenBounds.size.width;
    CGFloat cover_pictureH = 192;
    _cover_pictureF = CGRectMake(cover_pictureX, cover_pictureY, cover_pictureW, cover_pictureH);
     //帖子标题
    CGFloat post_titleX = TLCellBorderWidth + TLTableBorderWidth;
    CGFloat post_titleY = CGRectGetMaxY(_cover_pictureF) + TLCellBorderWidth;
    CGSize post_titleSize = [postDetail.user_post_info.post_title boundingRectWithSize:(CGSizeMake(ScreenBounds.size.width - 4*(TLCellBorderWidth + TLTableBorderWidth), MAXFLOAT)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
    _post_titleF = (CGRect){{post_titleX,post_titleY},post_titleSize};
    
    //二维码按键
    CGFloat codeButtonX = ScreenBounds.size.width- (TLCellBorderWidth + TLTableBorderWidth)-25;
    CGFloat codeButtonY = post_titleY;
    _codeF = CGRectMake(codeButtonX, codeButtonY, 25, 25);
    
    //用户头像
    CGFloat user_head_photoX = post_titleX;
    CGFloat user_head_photoY = CGRectGetMaxY(_post_titleF) + TLCellBorderWidth;
    CGFloat user_head_photoWH = TLIconSmallWH;
    _user_head_photoF = CGRectMake(user_head_photoX, user_head_photoY, user_head_photoWH, user_head_photoWH);
    
    //用户昵称
    CGFloat user_nick_nameX = CGRectGetMaxX(_user_head_photoF) + TLCellBorderWidth;
    CGFloat user_nick_nameY = user_head_photoY;
    CGSize user_nick_nameSize = [postDetail.user_post_info.user_nick_name sizeWithAttributes:@{NSFontAttributeName :TLNameFont}];
    _user_nick_nameF = (CGRect){{user_nick_nameX,user_nick_nameY},user_nick_nameSize};
    //时间
    CGSize post_timeSize = [postDetail.user_post_info.post_time sizeWithAttributes:@{NSFontAttributeName:TLTimeFont}];
    CGFloat post_timeX = ScreenBounds.size.width - post_timeSize.width - (TLCellBorderWidth + TLTableBorderWidth);
    CGFloat post_timeY = user_nick_nameY + TLCellBorderWidth;
    _post_timeF = (CGRect){{post_timeX,post_timeY},post_timeSize};
    //用户签名
    CGFloat user_signatureX = user_head_photoX;
    CGFloat user_signatureY = CGRectGetMaxY(_user_head_photoF) + TLCellBorderWidth;
     CGSize user_signatureSize = [postDetail.user_post_info.user_signature boundingRectWithSize:(CGSizeMake(ScreenBounds.size.width - 2*(TLCellBorderWidth + TLTableBorderWidth), MAXFLOAT)) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:TLContentFont} context:nil].size;
    _user_signatureF = (CGRect){{user_signatureX,user_signatureY},user_signatureSize};
    
    _height = CGRectGetMaxY(_user_signatureF);
}

@end
