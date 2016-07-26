//
//  TLEvaluationView.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-16.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLEvaluationView,TLProdEvaResult;


@protocol TLEvaluationViewDelegate <NSObject>

@optional

-(void)evaluationViewCancel:(TLEvaluationView *)evaluationView;
-(void)evaluationViewSure:(TLEvaluationView *)evaluationView withProdEvaResult:(TLProdEvaResult *)prodEvaResult;

@end

@interface TLEvaluationView : UIView

@property (nonatomic,strong) TLProdEvaResult *prodEvaResult;
@property (nonatomic,weak) id<TLEvaluationViewDelegate>delegate;

+(id)evaluationView;

@end
