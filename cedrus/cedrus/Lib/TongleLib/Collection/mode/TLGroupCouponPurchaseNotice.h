//
//  TLGroupCouponPurchaseNotice.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/10.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"


@protocol TLGroupCouponPurchaseNotice <NSObject>


@end

@interface TLGroupCouponPurchaseNotice : JSONModel

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *desc;

@end
