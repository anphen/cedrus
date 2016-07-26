//
//  TLMoshopViewController.h
//  tongle
//  魔店子控制器
//  Created by liu ruibin on 15-5-15.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>


@class TLMagicShop,TLQrdata,TLHomepage_ads,TLGroupCouponVoucher;

@interface TLMoshopViewController : UICollectionViewController

@property (nonatomic,strong) TLMagicShop    *magicShop;
@property (nonatomic,strong) TLQrdata       *qrdata;
@property (nonatomic,strong) TLHomepage_ads *HomepageMagicShop;
@property (nonatomic,strong) TLGroupCouponVoucher *groupCouponVoucher;

@property (nonatomic,copy) NSString *prod_mstore_id;

@property (nonatomic,copy) NSString    *user_id;
@property (nonatomic,copy) NSString    *token;
@property (nonatomic,copy) NSString    *mstore_id;
@property (nonatomic,weak)   UIButton    *cover;
@property (nonatomic,weak)   UIButton    *collect;
@property (nonatomic,weak)   UIButton    *qrcode;
@property (nonatomic,weak)   UIImageView *qrcodeImage;
@property (nonatomic,weak)   UIImageView *backImage;
@end
