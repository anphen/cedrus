//
//  TLMyOrderDetailTableViewController.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-10.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLMyOrderList;


@interface TLMyOrderDetailTableViewController : UITableViewController

@property (nonatomic,copy)  NSString *order_no;
@property (nonatomic,copy)  NSString *user_id;
@property (nonatomic,copy)  NSString *token;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,copy) NSString *actionType;

@end
