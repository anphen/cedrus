//
//  LTVersionItem.h
//  cedrus
//
//  Created by X Z on 16/7/27.
//  Copyright © 2016年 LT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTVersionItem : NSObject

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
