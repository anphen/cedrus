//
//  TLMyOrderProdEvaViewController.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-17.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLMyOrderList,TLEvaluationView,TLMyOrderProdDetail;


@interface TLMyOrderProdEvaViewController : UIViewController

@property (nonatomic,strong)    TLMyOrderList       *myorderList;
@property (nonatomic,weak)      TLEvaluationView    *evaluationView;
@property (nonatomic,strong)    TLMyOrderProdDetail *myOrderProdDetail;
@property (nonatomic,weak)      UIView              *blackView;
@property (nonatomic,weak)      UITableView         *tableview;
@property (nonatomic,copy)      NSString            *user_id;
@property (nonatomic,copy)      NSString            *token;
@property (nonatomic,copy)      NSString            *order_no;
@property (nonatomic,strong) NSArray *myorderListArray;


@end
