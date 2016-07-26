//
//  TLGroupProdDetailView.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/10.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLGroupCouponPurchaseInfo.h"


typedef void(^productDetail)();

@interface TLGroupProdDetailView : UIView

@property (nonatomic,strong) TLGroupCouponPurchaseInfo *groupCouponPurchaseInfo;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,copy) productDetail productDetailBlack;


@end
