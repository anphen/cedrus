//
//  TLPostDetailViewController.h
//  tongle
//  帖子详情控制器
//  Created by liu ruibin on 15-5-15.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLPostParam,TLQrdata,TLHomepage_ads,TLMoshopAd,TLGroupCouponVoucher;


@interface TLPostDetailViewController : UIViewController

@property (nonatomic,strong) TLPostParam    *postParam;
@property (nonatomic,strong) TLQrdata       *qrdata;
@property (nonatomic,strong) TLHomepage_ads *HomepagePost;
@property (nonatomic,strong) TLMoshopAd     *ad;
@property (nonatomic,strong) TLGroupCouponVoucher *groupCouponVoucher;

@property (nonatomic,copy)   NSString       *user_id;
@property (nonatomic,copy)   NSString       *post_id;
@property (nonatomic,copy)   NSString       *token;
@property (nonatomic,copy)   NSString       *user_nick_name;
@property (nonatomic,weak)   UIButton       *cover;
@property (nonatomic,weak)   UIButton       *collect;
@property (nonatomic,weak)   UIButton       *share;
@property (nonatomic,weak)   UIImageView    *qrcodeImage;
@end
