//
//  TLCreateAddressViewController.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-6.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLCreateAddressViewController,TLAddress;


@protocol TLCreateAddressViewControllerDelegate <NSObject>

@optional

-(void)createAddressViewController:(TLCreateAddressViewController *)TLCreateAddressViewController WithAddress:(NSMutableArray *)address;

@end

@interface TLCreateAddressViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *consignee;

@property (weak, nonatomic) IBOutlet UITextField *tel;

@property (weak, nonatomic) IBOutlet UITextField *area_id;

@property (weak, nonatomic) IBOutlet UITextField *prov_city_area;

@property (weak, nonatomic) IBOutlet UITextView *address;

@property (nonatomic,weak) id<TLCreateAddressViewControllerDelegate>  delegate;


- (IBAction)save:(UIBarButtonItem *)sender;


@end
