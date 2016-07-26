//
//  TLBasicData.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-4.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLBaseDateType.h"

@interface TLBasicData : JSONModel

@property (nonatomic,strong) NSArray<TLBaseDateType,ConvertOnDemand> *base_data_list;


@end
