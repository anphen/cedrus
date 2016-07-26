//
//  TLProdBoby.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-4.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLProduct.h"

@interface TLProdBoby : JSONModel

@property (nonatomic,copy)      NSString                            *data_total_count;
@property (nonatomic,strong)    NSArray<TLProduct,ConvertOnDemand>  *my_prod_list;

@end
