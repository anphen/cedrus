//
//  TLprodPurchaseView.h
//  tongle
//
//  Created by liu ruibin on 15-5-19.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLProdDetails.h"

@protocol TLprodPurchaseViewDelegate <NSObject>

@optional

-(void)prodPurchaseViewShare;
-(void)prodPurchaseViewProdDetails;
-(void)prodPurchaseViewProdIntegrateDetails;
@end

@interface TLprodPurchaseView : UIView
@property (nonatomic,assign,readonly) CGFloat height;
@property (nonatomic,strong) TLProdDetails *prodDetails;
@property (nonatomic,weak) id<TLprodPurchaseViewDelegate> delegate;
@property (nonatomic,copy) NSString *prod_Price;
@property (nonatomic,weak) UIScrollView *prodImage;


@end
