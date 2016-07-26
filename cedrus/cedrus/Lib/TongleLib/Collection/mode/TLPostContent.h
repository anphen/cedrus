//
//  TLPostContent.h
//  tongle
//
//  Created by liu ruibin on 15-5-15.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"

@protocol  TLPostContent <NSObject>


@end

@interface TLPostContent : JSONModel

//帖子图片URL
@property (nonatomic,copy) NSString *pic_url;
//帖子图片说明
@property (nonatomic,copy) NSString *pic_memo;
//帖子关联对象类别
@property (nonatomic,copy) NSString *related_type;
//帖子关联对象ID
@property (nonatomic,copy) NSString *object_id;

@property (nonatomic,copy) NSString *relation_id;

@property (nonatomic,copy) NSString *coupon_flag;

@end
