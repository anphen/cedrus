//
//  TLProdParam.h
//  tongle
//
//  Created by liu ruibin on 15-5-21.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLProdParamsterList.h"

@interface TLProdParam : JSONModel

@property (nonatomic,strong) NSArray<TLProdParamsterList,ConvertOnDemand> *prod_parameter_list;

@end
