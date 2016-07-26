//
//  TLVersionRequest.h
//  tongle
//
//  Created by liu on 15-4-29.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLVersionRequest : NSObject

//移动平台编号（必须指定）
@property (nonatomic,copy) NSString *mobile_os_no;
//本地APP版本号（必须指定）
@property (nonatomic,copy) NSString *local_app_version;
//APP内部编号（可为空）
//@property (nonatomic,copy) NSString *app_inner_no;

@end
