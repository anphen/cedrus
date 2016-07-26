//
//  TLVersionParam.h
//  tongle
//
//  Created by liu on 15-4-29.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"


@interface TLVersionParam : JSONModel

//是否有更新
@property (nonatomic,copy) NSString *has_update;
//是否强制更新
@property (nonatomic,copy) NSString *force_update;
//APP新版本号
@property (nonatomic,copy) NSString *recently_version_no;
//APP新版本描述
@property (nonatomic,copy) NSString *recently_version_tips;
//APP新版本下载链接URL
@property (nonatomic,copy) NSString *recently_version_link;

@end
