//
//  TLAddress.h
//  TL11
//
//  Created by liu on 15-4-14.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "JSONModel.h"

@protocol TLAddress

@end


@interface TLAddress : NSObject
//地址编号
@property (nonatomic,copy) NSString *address_no;
//收货人姓名
@property (nonatomic,copy) NSString *consignee;
//电话
@property (nonatomic,copy) NSString *tel;
//收货省份编码
@property (nonatomic,copy) NSString *province_id;
//收货省份名称
@property (nonatomic,copy) NSString *province_name;
//收货市编码
@property (nonatomic,copy) NSString *city_id;
//收货市名称
@property (nonatomic,copy) NSString *city_name;
//收货地区编码
@property (nonatomic,copy) NSString *area_id;
//收货地区名称
@property (nonatomic,copy) NSString *area_name;
//详细地址
@property (nonatomic,copy) NSString *address;
//邮编
@property (nonatomic,copy) NSString *post_code;
//默认标示
@property (nonatomic,copy) NSString *default_flag;


//@property (nonatomic,assign) BOOL IsSelected;


@end
