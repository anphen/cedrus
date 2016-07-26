//
//  TLProdParamsterList.h
//  tongle
//
//  Created by liu ruibin on 15-5-21.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLProdParameters.h"

@protocol TLProdParamsterList <NSObject>

@end

@interface TLProdParamsterList : JSONModel

@property (nonatomic,copy)      NSString                                    *module_name;
@property (nonatomic,strong)    NSArray<TLProdParameters,ConvertOnDemand>   *parameters;


@end
