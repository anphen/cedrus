//
//  TLGroupPurchaseShopView.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/4.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>


@class TLGroupPurchaseShopView,TLGroupCouponStoreInfo;

@protocol TLGroupPurchaseShopViewDelegate <NSObject>

@optional

-(void)groupPurchaseShopView:(TLGroupPurchaseShopView *)groupPurchaseShopView selectShopListButton:(UIButton *)button;

@end



@interface TLGroupPurchaseShopView : UIView

@property (nonatomic,assign) NSInteger height;
@property (nonatomic,strong) TLGroupCouponStoreInfo *coupon_store_info;
@property (nonatomic,assign) id<TLGroupPurchaseShopViewDelegate>delegate;

@end
