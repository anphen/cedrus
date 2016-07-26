//
//  TLGroupCouponCodeurlInfo.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/15.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"


@protocol TLGroupCouponCodeurlInfo <NSObject>


@end


@interface TLGroupCouponCodeurlInfo : JSONModel

@property (nonatomic,copy) NSString *coupon_2d_qrcode_url;
@property (nonatomic,copy) NSString *coupon_1d_qrcode_url;

@end
