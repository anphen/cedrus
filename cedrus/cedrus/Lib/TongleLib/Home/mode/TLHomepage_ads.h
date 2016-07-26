//
//  TLHomepage_ads.h
//  tongle
// 魔店广告模型
//  Created by liu ruibin on 15-4-29.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@protocol TLHomepage_ads


@end

@interface TLHomepage_ads : JSONModel
//活动编号
@property (nonatomic,copy) NSString *promotion_no;
//活动模式
@property (nonatomic,copy) NSString *promotion_mode;
//活动对象
@property (nonatomic,copy) NSString *object_id;
//活动图片url
@property (nonatomic,copy) NSString *mobile_pic_url;
//二维码关联
@property (nonatomic,copy) NSString *relation_id;
//团购标识
@property (nonatomic,copy) NSString *coupon_flag;

//活动标题
@property (nonatomic,copy) NSString *promotion_title;





@end
