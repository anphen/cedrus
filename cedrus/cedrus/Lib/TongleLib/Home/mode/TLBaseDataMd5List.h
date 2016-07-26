//
//  TLBaseDataMd5List.h
//  tongle
//
//  Created by jixiaofei-mac on 15-11-4.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLBaseDataMd5.h"

@interface TLBaseDataMd5List : JSONModel

@property (nonatomic,strong) NSArray<TLBaseDataMd5,ConvertOnDemand> *base_data_md5_list;

@end
