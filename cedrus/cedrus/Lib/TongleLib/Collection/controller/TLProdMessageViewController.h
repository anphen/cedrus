//
//  TLProdMessageViewController.h
//  tongle
//  产品详情控制器
//  Created by liu ruibin on 15-5-21.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLNavigationBar,TLProdDetails,TLProdMessageViewController;

@protocol TLProdMessageViewControllerDelegate <NSObject>

-(void)prodMessageViewController:(TLProdMessageViewController *)prodMessageViewController withProdDetails:(TLProdDetails *)prodDetails;

@end


@interface TLProdMessageViewController : UIViewController

@property (nonatomic,strong)    TLProdDetails   *prodDetails;
@property (nonatomic,strong)    NSString        *user_id;
@property (nonatomic,strong)    NSString        *token;
@property (nonatomic,strong)    NSString        *product_id;
@property (nonatomic,weak)      UIButton        *cover;
@property (nonatomic,weak)      UIButton        *collect;
@property (nonatomic,weak)      UIButton        *qrcode;
@property (nonatomic,weak)      UIImageView     *qrcodeImage;
@property (nonatomic,weak)      TLNavigationBar *navigationBar;
@property (nonatomic,weak)      UIImageView    *backImage;
@property (nonatomic,strong)    NSString        *type;
@property (nonatomic,strong)    NSString        *prodType;

@property (nonatomic,assign)id<TLProdMessageViewControllerDelegate>delegate;

@end
