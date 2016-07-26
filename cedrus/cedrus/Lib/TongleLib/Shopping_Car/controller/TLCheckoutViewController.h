//
//  TLCheckoutViewController.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-2.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLOrderDetailMeg;

@interface TLCheckoutViewController : UITableViewController

@property (nonatomic,strong) NSArray *chectoutProduct;
@property (nonatomic,strong) TLOrderDetailMeg *orderDetailMeg;
@end
