//
//  TLGroupPurchaseShopListController.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/7.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLGroupProductDetail;

@interface TLGroupPurchaseShopListController : UITableViewController

@property (nonatomic,strong) TLGroupProductDetail *groupProductDetail;
@property (nonatomic,copy) NSString *prod_id;

@end
