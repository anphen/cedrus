//
//  TLDeliveriesDataViewController.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-5.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLBaseDateType,TLDeliveriesDataViewController,TLDataList;


@protocol  TLDeliveriesDataViewControllerDelegate <NSObject>

@optional

-(void)changeDeliveriesDateWithController:(TLDeliveriesDataViewController *)selectAddressViewController didAddress:(TLDataList *)dataList;
@end

@interface TLDeliveriesDataViewController : UITableViewController

@property (nonatomic,strong) TLBaseDateType *baseDateType;
@property (nonatomic,assign) id<TLDeliveriesDataViewControllerDelegate> delegate;
@end
