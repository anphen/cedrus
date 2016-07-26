//
//  TLPostFrame.m
//  tongle
//
//  Created by liu on 15-4-25.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "TLPostFrame.h"
#import "TLPostParam.h"
#import "TLPhotoListView.h"
#import "TLCommon.h"

@implementation TLPostFrame

-(void)setPostParam:(TLPostParam *)postParam
{
    _postParam = postParam;
    
    CGFloat cellWith = [UIScreen mainScreen].bounds.size.width;
    
    // topView
    CGFloat topViewW = cellWith;
    CGFloat topViewH = 0;
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    
    
    //用户头像
    CGFloat iconX = TLCellBorderWidth;
    CGFloat iconY = 5;
    CGFloat iconWH = TLIconSmallWH;
    _user_head_photoF=  CGRectMake(iconX, iconY, iconWH, iconWH);
    
     //用户昵称
    CGFloat nameX = CGRectGetMaxX(_user_head_photoF) +TLCellBorderWidth;
    CGFloat nameY = iconY;
    CGSize nameSize = [postParam.user_nick_name sizeWithAttributes:@{NSFontAttributeName:TLNameFont}];
    _user_nick_nameF = (CGRect){{nameX,nameY},nameSize};
    
    
    //帖子发布时间
    CGFloat timeY = iconY;
    CGSize timeSize = [postParam.post_time sizeWithAttributes:@{NSFontAttributeName:TLContentFont}];
    CGFloat timeX = ScreenBounds.size.width - timeSize.width-TLCellBorderWidth;
    _post_timeF = (CGRect){{timeX,timeY},timeSize};
    
    
    //帖子转发内容
    CGFloat commentX = nameX;
    CGFloat commentY = CGRectGetMaxY(_user_nick_nameF) + TLCellBorderWidth * 0.5;
    // CGSize commentSize = [postParam.post_comment sizeWithFont:TLContentFont constrainedToSize:(CGSizeMake(cellWith - 2*TLCellBorderWidth - iconWH, MAXFLOAT))];
    _post_commentF = CGRectMake(commentX, commentY, ScreenBounds.size.width-commentX-TLCellBorderWidth, 20);
    
    
    //帖子标题
    CGFloat titleX = iconX;
    CGFloat titleY = CGRectGetMaxY(_user_head_photoF) + TLCellBorderWidth * 0.5;
    _first_post_titleF = CGRectMake(titleX, titleY,ScreenBounds.size.width-2*TLCellBorderWidth , 20);
    

    CGSize photoListSize = CGSizeMake(0, 0);
    
    if (postParam.first_post_thumbnail_pic_url.count)
    {
        int number = (int)postParam.first_post_thumbnail_pic_url.count < 9 ? (int)postParam.first_post_thumbnail_pic_url.count:9;
        photoListSize = [TLPhotoListView photoListSizeWithCount:number];
    }
    
    CGFloat photoListY = 0;
    if (postParam.first_post_title.length && ![postParam.post_id isEqualToString:postParam.first_post_id]) {
        photoListY = CGRectGetMaxY(_first_post_titleF) + TLCellBorderWidth * 0.5;
    }else
    {
        photoListY = CGRectGetMaxY(_user_head_photoF) + TLCellBorderWidth * 0.5;
    }
    
        CGFloat photoListX =titleX;
        _first_post_thumbnail_pic_urlF = (CGRect){{photoListX,photoListY},photoListSize};

    
    CGFloat divisionY = 0;
    if (postParam.first_post_thumbnail_pic_url.count) {
        divisionY = CGRectGetMaxY(_first_post_thumbnail_pic_urlF);
    }else
    {
        divisionY = CGRectGetMaxY(_first_post_titleF);
    }
        CGFloat divisionX = 0;
        CGFloat divisionW = cellWith;
        CGFloat divisionH = 6;
        _divisionF = CGRectMake(divisionX, divisionY+5, divisionW, divisionH);
        
        topViewH = CGRectGetMaxY(_divisionF);
        //整个cell高度
        _cellHeight = topViewH ;
        //top的frame
        _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
        //topViewH = CGRectGetMaxY(_post_timeF);
}


@end
