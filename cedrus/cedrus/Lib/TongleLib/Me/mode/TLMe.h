//
//  TLMe.h
//  TL11
//
//  Created by liu on 15-4-14.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"


@interface TLMe : JSONModel
/**
 *  用户ID
 */
@property (nonatomic,copy) NSString *user_id;
/**
 *  用户名称
 */
@property (nonatomic,copy) NSString *user_name;
/**
 *  用户昵称
 */
@property (nonatomic,copy) NSString *user_nick_name;

/**
 *  用户消费积分余额
 */
@property (nonatomic,copy) NSString *user_sales_point;

/**
 *  用户返利积分余额
 */
@property (nonatomic,copy) NSString *user_rebate_point;
/**
 *  用户账户余额
 */
@property (nonatomic,copy) NSString *user_account_balance;
/**
 *  用户优惠券
 */
@property (nonatomic,copy) NSString *user_coupons;
/**
 *  用户粉丝数
 */
@property (nonatomic,copy) NSString *user_fans;
/**
 *  用户关注数
 */
@property (nonatomic,copy) NSString *user_follows;
/**
 *  用户头像
 */
//@property (nonatomic,copy) NSString *user_head_photo_url;
@property (nonatomic,copy) NSString *user_qr_code_url;

@property (nonatomic,copy) NSString *user_sex;
//身份证
@property (nonatomic,copy) NSString *user_id_no;
//个人积分
@property (nonatomic,copy) NSString *user_customs_flag;

@property (nonatomic,copy) NSString *user_phone;

@property (nonatomic,copy) NSString *user_photo_url;








@end
