//
//  TLProductAll.h
//  tongle
//
//  Created by liu on 15-5-4.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLProduct.h"

@interface TLProductAll : JSONModel

@property (nonatomic,copy)      NSString                            *data_total_count;
@property (nonatomic,strong)    NSArray<TLProduct,ConvertOnDemand>  *prod_list;

@end
