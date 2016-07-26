//
//  TLPersonalInfoModefyRequest.h
//  tongle
//
//  Created by jixiaofei-mac on 15-9-29.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLCommon.h"


@interface TLPersonalInfoModefyRequest : NSObject

@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString *head_photo_binary_data;
@property (nonatomic,copy) NSString *user_nick_name;
@property (nonatomic,copy) NSString *sex;
@property (nonatomic,copy) NSString *TL_USER_TOKEN_REQUEST;
@property (nonatomic,copy) NSString *id_no;
@property (nonatomic,copy) NSString *customs_flag;
@property (nonatomic,copy) NSString *user_name;

@end
