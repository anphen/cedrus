//
//  TLGroupShopSubmitOrderViewController.h
//  tongle
//
//  Created by jixiaofei-mac on 16/3/8.
//  Copyright © 2016年 com.isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLGroupProductDetail,TLGroupOrder;


typedef void(^black)();

@interface TLGroupShopSubmitOrderViewController : UIViewController

@property (nonatomic,copy) black ff;
@property (nonatomic,strong) TLGroupProductDetail *groupProductDetail;
@property (nonatomic,strong) TLGroupOrder *groupOrder;
@property (nonatomic,copy) NSString *type;

@end
