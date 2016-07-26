//
//  TLMagicShopAd.h
//  tongle
//
//  Created by liu ruibin on 15-5-6.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLMagicShopAd;


@protocol TLMagicShopAdDelegate <NSObject>

@optional
-(void)JumpControllerWithMagicShopAd;//:(TLMagicShopAd *)magicShopAd;
-(void)JumpControllerWithMagicImageWithButton:(UIButton *)button;

@end

@interface TLMagicShopAd : UIView

@property (nonatomic,strong) NSArray *magicShop;
@property (nonatomic,assign) int height;
@property (nonatomic,weak) id<TLMagicShopAdDelegate> delegate;



@end
