//
//  TLGroupPurchaseViewShopView.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/3.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLGroupProductDetail;

typedef void(^productDetail)();
typedef void(^productShare)();
typedef void(^productEvaluate)();


@interface TLGroupPurchaseViewShopView : UIView

@property (nonatomic,assign) NSUInteger height;
@property (nonatomic,strong)TLGroupProductDetail *groupProductDetail;
@property (nonatomic,weak) UIScrollView *prodImage;
@property (nonatomic,copy) productDetail   productDetailBlack;
@property (nonatomic,copy) productShare    productShareBlack;
@property (nonatomic,copy) productEvaluate productEvaluateBlack;


@end
