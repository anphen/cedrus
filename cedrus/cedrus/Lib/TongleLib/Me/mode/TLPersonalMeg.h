//
//  TLPersonalMeg.h
//  tongle
//
//  Created by liu on 15-4-22.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface TLPersonalMeg : JSONModel<NSCoding>
//用户ID
@property (nonatomic,copy) NSString *user_id;
//用户区分
@property (nonatomic,copy) NSString *user_type;
//是否首次登录
@property (nonatomic,copy) NSString *is_first_login;
//是否必须修改密码
@property (nonatomic,copy) NSString *require_change_pwd;
//用户昵称
@property (nonatomic,copy) NSString *user_nick_name;
//用户头像URL
@property (nonatomic,copy) NSString *user_head_photo_url;
//用户性别
@property (nonatomic,copy) NSString *user_sex;
//Token
@property (nonatomic,copy) NSString *token;
//酬客协议显示标志
@property (nonatomic,copy) NSString *is_protocol_show;
//酬客协议URL
@property (nonatomic,copy) NSString *payoff_protocol_url;

@end



