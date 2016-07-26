//
//  TLQrdata.h
//  tongle
//
//  Created by jixiaofei-mac on 15-7-3.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"

@interface TLQrdata : JSONModel

@property (nonatomic,copy) NSString *code_type;
@property (nonatomic,copy) NSString *prod_id;
@property (nonatomic,copy) NSString *post_id;
@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString *store_id;
@property (nonatomic,copy) NSString *org_id;
@property (nonatomic,copy) NSString *relation_id;

@end
