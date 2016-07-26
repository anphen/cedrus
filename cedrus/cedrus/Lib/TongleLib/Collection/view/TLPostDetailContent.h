//
//  TLPostDetailContent.h
//  tongle
//
//  Created by liu ruibin on 15-5-18.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLPostContent,TLPostDetailContent;

@protocol TLPostDetailContentDelegate <NSObject>

@optional

-(void)PostDetailContent:(TLPostDetailContent *)postDetailContent;

@end


@interface TLPostDetailContent : UIView

@property (nonatomic,strong)    TLPostContent   *postContent;
//帖子图片
@property (nonatomic,weak)      UIImageView     *pic;
//帖子图片说明
@property (nonatomic,weak)      UILabel         *pic_memo;

@property (nonatomic,assign,readonly) CGFloat   hight;

@property (nonatomic,assign) id<TLPostDetailContentDelegate> delegate;

@end
