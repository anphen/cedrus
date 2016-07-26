//
//  TLProd_type_List.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-18.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"

@class TLProd_type_List;

@protocol TLProd_type_List <NSObject>

@end

@interface TLProd_type_List : JSONModel

@property (nonatomic,copy)NSString *type_id;
@property (nonatomic,copy)NSString *type_name;
@property (nonatomic,copy)NSString *desc;
@property (nonatomic,copy)NSString *pic_url;
@property (nonatomic,strong) NSArray<TLProd_type_List,ConvertOnDemand> *sub_list;


@end
