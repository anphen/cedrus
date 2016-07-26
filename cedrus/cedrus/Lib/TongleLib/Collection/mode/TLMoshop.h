//
//  TLMoshop.h
//  tongle
//
//  Created by liu ruibin on 15-5-15.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLMoshopAd.h"
#import "TLProduct.h"

@interface TLMoshop : JSONModel

@property (nonatomic,strong)    NSArray<TLMoshopAd,ConvertOnDemand> *ad_list;
@property (nonatomic,strong)    NSArray<TLProduct,ConvertOnDemand>  *prod_list;
@property (nonatomic,copy)      NSString                            *mstore_id;
@property (nonatomic,copy)      NSString                            *mstore_name;
@property (nonatomic,copy)      NSString                            *mstore_favorited_by_me;
@property (nonatomic,copy) NSString *vouchers_text;
@property (nonatomic,copy) NSString *vouchers_url;
@property (nonatomic,copy) NSString *vouchers_title;

@end
