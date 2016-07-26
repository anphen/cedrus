//
//  TLSearch.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-25.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLMagicShop.h"
#import "TLMasterParam.h"
#import "TLPostParam.h"
#import "TLProduct.h"

@interface TLSearch : JSONModel

@property (nonatomic,strong)    NSArray<TLMagicShop,ConvertOnDemand>    *mstore_list;
@property (nonatomic,strong)    NSArray<TLMasterParam,ConvertOnDemand>  *user_list;
@property (nonatomic,strong)    NSArray<TLPostParam,ConvertOnDemand>    *post_list;
@property (nonatomic,strong)    NSArray<TLProduct,ConvertOnDemand>      *prod_list;

@end
