//
//  TLIntegrateDetailController.h
//  tongle
//
//  Created by jixiaofei-mac on 15/11/10.
//  Copyright © 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLProdDetails,TLUser_account_info,TLMyOrderDetail,TLMyAccount_list,TLMoshop,TLHomepage_ads,TLGroupOrderProdBaseInfo;

@interface TLIntegrateDetailController : UIViewController

@property (nonatomic,strong) TLProdDetails *prodDetails;
@property (nonatomic,strong) TLUser_account_info *user_account_info;
@property (nonatomic,strong) TLMyAccount_list *MyAccount;
@property (nonatomic,strong) TLMyOrderDetail *myOrderDetail;
@property (nonatomic,strong) TLMoshop      *moshop;
@property (nonatomic,strong) TLHomepage_ads   *homepage_ads;
@property (nonatomic,strong) TLGroupOrderProdBaseInfo *prodBaseInfo;
@property (nonatomic,copy) NSString *order_no;
@property (nonatomic,copy)   NSString *Title;
@property (nonatomic,copy)   NSString *url;
@end
