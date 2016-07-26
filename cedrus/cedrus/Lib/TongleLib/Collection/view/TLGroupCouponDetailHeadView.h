//
//  TLGroupCouponDetailHeadView.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/18.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>


@class TLGroupCouponDetail;

typedef void(^codeBlack)();
typedef void(^groupCouponDetail)();
typedef void(^reBackProduct)();
typedef void(^tendMessage)(NSString *);

@interface TLGroupCouponDetailHeadView : UIView

@property (nonatomic,strong) TLGroupCouponDetail *groupCouponDetail;

@property (nonatomic,copy) codeBlack codeblack;

@property (nonatomic,copy) groupCouponDetail couponDetail;

@property (nonatomic,copy) reBackProduct rebackProduct;

@property (nonatomic,copy) tendMessage tendmessage;

+(instancetype)createView;

@end
