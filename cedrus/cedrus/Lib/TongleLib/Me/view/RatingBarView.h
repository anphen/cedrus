//
//  RatingBarView.h
//  CustomRatingBar
//
//  Created by jixiaofei-mac on 16/4/19.
//  Copyright © 2016年 HHL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RatingBarView,TLGroupOrder;

@protocol RatingBarViewDelegate <NSObject>

-(void)ratingBarView:(RatingBarView *)ratingBarView withEstimation:(NSString *)estimation comment:(NSString *)comment groupOrder:(TLGroupOrder *)groupOrder;

-(void)ratingBarViewCancel:(RatingBarView *)ratingBarView;

@end

@interface RatingBarView : UIView

@property (nonatomic,strong) TLGroupOrder *groupOrder;
@property (nonatomic,assign) id<RatingBarViewDelegate>delegate;

@end
