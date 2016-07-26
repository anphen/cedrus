//
//  TLThis_Shop_Array.h
//  tongle
//
//  Created by jixiaofei-mac on 15-7-8.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLShopCar.h"

@interface TLThis_Shop_Array : JSONModel

@property (nonatomic,strong) NSArray<TLShopCar,ConvertOnDemand> *this_shopping_cart;
@end
