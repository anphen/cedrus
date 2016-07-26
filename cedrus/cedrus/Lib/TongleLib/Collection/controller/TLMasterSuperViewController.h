//
//  TLMasterSuperViewController.h
//  tongle
//  超级达人控制器
//  Created by liu ruibin on 15-5-13.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLMasterParam,TLMasterSuperViewController,TLNavigationBar,TLQrdata,TLHomepage_ads,TLPostContent,TLMoshopAd,TLExpertUserMessage,TLGroupCouponVoucher;


@interface TLMasterSuperViewController : UIViewController

@property (nonatomic,strong) TLMasterParam  *master;
@property (nonatomic,strong) TLQrdata       *qrdata;
@property (nonatomic,strong) TLHomepage_ads *HomepageMaster;
@property (nonatomic,strong) TLPostContent  *postContent;
@property (nonatomic,strong) TLMoshopAd     *ad;
@property (nonatomic,strong) TLExpertUserMessage *expertUserMessage;
@property (nonatomic,weak)   TLNavigationBar *navigationBar;
@property (nonatomic,strong) TLGroupCouponVoucher *groupCouponVoucher;

@property (nonatomic,copy) NSString       *user_id;
@property (nonatomic,copy) NSString       *user_nick_name;
@property (nonatomic,copy) NSString       *token;
@property (nonatomic,copy) NSString       *expert_user_id;
@property (nonatomic,weak)   UIButton       *cover;
@property (nonatomic,weak)   UIButton       *collect;
@property (nonatomic,weak)   UIButton       *qrcode;
@property (nonatomic,weak)   UIImageView    *qrcodeImage;
@property (nonatomic,weak)   UIImageView    *backImage;
@property (nonatomic,weak)   UINavigationBar *bar;



@end
