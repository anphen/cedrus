//
//  TLProdCollectView.h
//  tongle
//
//  Created by liu ruibin on 15-5-20.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TLProdCollectViewDelegate <NSObject>

@optional

-(void)ProdCollectViewCancelWithCollect:(BOOL)collectBtn baby:(BOOL)babyBtn;
-(void)ProdCollectViewSureWithCollect:(BOOL)collectBtn baby:(BOOL)babyBtn;

@end


@interface TLProdCollectView : UIView

@property (nonatomic,weak) id<TLProdCollectViewDelegate> delegate;


+(instancetype)prodCollect;
@end
