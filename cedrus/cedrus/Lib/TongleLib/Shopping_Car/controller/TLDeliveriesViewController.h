//
//  TLDeliveriesViewController.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-5.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLBaseDateType,TLDeliveriesViewController,TLDataList;


@protocol  TLDeliveriesViewControllerDelegate <NSObject>

@optional

-(void)changeDeliveriesWithController:(TLDeliveriesViewController *)selectAddressViewController didAddress:(TLDataList *)dataList;

@end


@interface TLDeliveriesViewController : UITableViewController

@property (nonatomic,strong) TLBaseDateType  *baseDateType;
@property (nonatomic,assign) id<TLDeliveriesViewControllerDelegate> delegate;

@end
