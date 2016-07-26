//
//  TLShopList.h
//  tongle
//
//  Created by liu on 15-5-7.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "TLShopCar.h"


@interface TLShopList : JSONModel
@property (nonatomic,strong) NSMutableArray<TLShopCar,ConvertOnDemand> *my_shopping_cart;

@end
