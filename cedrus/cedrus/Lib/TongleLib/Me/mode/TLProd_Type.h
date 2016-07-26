//
//  TLProd_Type.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-18.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLProd_type_List.h"

@interface TLProd_Type : JSONModel

@property (nonatomic,strong) NSArray<TLProd_type_List,ConvertOnDemand> *type_list;


@end
