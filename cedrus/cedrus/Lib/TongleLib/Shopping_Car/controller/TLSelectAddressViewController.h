//
//  TLSelectAddressViewController.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-3.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLSelectAddressViewController,TLAddress;


@protocol  TLSelectAddressViewControllerDelegate <NSObject>

@optional

-(void)changeAddressWithController:(TLSelectAddressViewController *)selectAddressViewController didAddress:(TLAddress *)address;
-(void)changeAddressWithController:(TLSelectAddressViewController *)selectAddressViewController didNoAddress:(TLAddress *)address;

@end

@interface TLSelectAddressViewController : UITableViewController

@property (nonatomic,strong) NSMutableArray *allAddresses;
@property (nonatomic,assign) id<TLSelectAddressViewControllerDelegate>delegate;

@end
