//
//  TLPersonalModify.h
//  tongle
//
//  Created by jixiaofei-mac on 15-9-10.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"

@interface TLPersonalModify : JSONModel

@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString *head_photo_binary_data;
@property (nonatomic,copy) NSString *user_nike_name;
@property (nonatomic,copy) NSString *sex;

@end
