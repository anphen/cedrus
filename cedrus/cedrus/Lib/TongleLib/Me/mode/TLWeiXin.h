//
//  TLWeiXin.h
//  tongle
//
//  Created by jixiaofei-mac on 15-8-6.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"

@interface TLWeiXin : JSONModel

@property (nonatomic,copy) NSString *app_id;
@property (nonatomic,copy) NSString *partner_id;
@property (nonatomic,copy) NSString *prepay_id;
@property (nonatomic,copy) NSString *package;
@property (nonatomic,copy) NSString *nonce_str;
@property (nonatomic,copy) NSString *timestamp;
@property (nonatomic,copy) NSString *sign;

@end
