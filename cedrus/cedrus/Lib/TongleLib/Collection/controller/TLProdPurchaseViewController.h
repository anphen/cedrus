//
//  TLProdPurchaseViewController.h
//  tongle
//  产品信息控制器
//  Created by liu ruibin on 15-5-19.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  TLProduct,TLQrdata,TLHomepage_ads,TLPostContent,TLMoshopAd,TLMyOrderDetailList,TLGroupCouponVoucher;


@interface TLProdPurchaseViewController : UIViewController

@property (nonatomic,strong) TLProduct      *product;
@property (nonatomic,strong) TLProduct      *mstoreproduct;
@property (nonatomic,strong) TLProduct      *mybabyproduct;
@property (nonatomic,strong) TLProduct      *prod_hotProd;
@property (nonatomic,strong) TLProduct      *prodOtherBody;
@property (nonatomic,strong) TLProduct      *prodOrg;
@property (nonatomic,strong) TLMyOrderDetailList      *myorderproduct;
@property (nonatomic,strong) TLQrdata       *qrdata;
@property (nonatomic,strong) TLHomepage_ads *Homepageprod;
@property (nonatomic,strong) TLPostContent  *postContent;
@property (nonatomic,strong) TLMoshopAd     *ad;
@property (nonatomic,strong) TLGroupCouponVoucher *groupCouponVoucher;


@property (nonatomic,copy)   NSString       *user_id;
@property (nonatomic,copy)   NSString       *prod_id;
@property (nonatomic,copy)   NSString       *token;

@property (nonatomic,weak)   UIButton       *cover;
@property (nonatomic,weak)   UIButton       *collect;
@property (nonatomic,weak)   UIButton       *qrcode;
@property (nonatomic,weak)   UIImageView    *qrcodeImage;
@property (nonatomic,weak)   UIImageView    *backImage;

@end
