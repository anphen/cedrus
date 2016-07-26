//
//  TLGroupCouponVoucherLinkInfo.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/22.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"

@protocol TLGroupCouponVoucherLinkInfo <NSObject>


@end

@interface TLGroupCouponVoucherLinkInfo : JSONModel

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *pic;
@property (nonatomic,copy) NSString *link_type;
@property (nonatomic,copy) NSString *link_id;

@end
