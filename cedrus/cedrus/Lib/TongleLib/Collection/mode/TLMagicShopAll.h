//
//  TLMagicShopAll.h
//  tongle
//
//  Created by liu on 15-4-24.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLMagicShop.h"

@interface TLMagicShopAll : JSONModel

@property (nonatomic,strong)    NSArray<TLMagicShop,ConvertOnDemand>    *mstore_list;
@property (nonatomic,copy)      NSString                                *data_total_count;


@end
