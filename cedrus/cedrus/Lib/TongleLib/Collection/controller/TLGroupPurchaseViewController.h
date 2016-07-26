//
//  TLGroupPurchaseViewController.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/1.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLProduct;

@interface TLGroupPurchaseViewController : UIViewController

@property (nonatomic,strong) TLProduct *product;
@property (nonatomic,copy) NSString *action;

@end
