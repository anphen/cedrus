//
//  TLExpertUserMessage.h
//  tongle
//
//  Created by jixiaofei-mac on 15-10-27.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"

@interface TLExpertUserMessage : JSONModel

@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString *user_nick_name;
@property (nonatomic,copy) NSString *user_signature;
@property (nonatomic,copy) NSString *user_head_photo_url;
@property (nonatomic,copy) NSString *user_favorited_by_me;

@end
