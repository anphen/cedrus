//
//  TLRegister.h
//  tongle
//
//  Created by liu on 15-4-23.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"


@interface TLRegister : JSONModel

//手机号码（必须指定）
@property (nonatomic,copy) NSString *phone_number;
//密码（必须指定）
@property (nonatomic,copy) NSString *password;
//验证码（必须指定）
@property (nonatomic,copy) NSString *verification_code;
//昵称（可为空）
@property (nonatomic,copy) NSString *user_nick_name;
//渠道编码（可为空）
@property (nonatomic,copy) NSString *channel_no;
//平台系统版本号（必须指定）
@property (nonatomic,copy) NSString *mobile_os_version;
//终端设备描述名（可为空）
@property (nonatomic,copy) NSString *terminal_device;
//推荐码（可为空）
@property (nonatomic,copy) NSString *recommend_code;

@property (nonatomic,copy) NSString *register_user_id;

@property (nonatomic,copy) NSString *referee_id;
@end
