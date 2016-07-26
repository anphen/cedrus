//
//  TLOrderViewController.h
//  TL11
//
//  Created by liu on 15-4-16.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLMyOrder,TLNavigationBar,TLEvaluationView;


@interface TLOrderViewController : UIViewController

@property (nonatomic,strong) TLMyOrder *myOrder;

@property (nonatomic,strong) NSMutableArray *noPayment;
@property (nonatomic,strong) NSMutableArray *noReceive;
@property (nonatomic,strong) NSMutableArray *noEvaluation;
@property (nonatomic,weak) TLNavigationBar *navigationBar;
@property (nonatomic,weak) TLEvaluationView *evaluationView;
@property (nonatomic,weak) UIView *blackView;
@property (nonatomic,copy) NSString *type;

@end
