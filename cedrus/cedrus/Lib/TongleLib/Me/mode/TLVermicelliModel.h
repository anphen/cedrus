//
//  TLVermicelliModel.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-26.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLMasterParam.h"

@interface TLVermicelliModel : JSONModel

@property (nonatomic,copy) NSString *data_total_count;
@property (nonatomic,strong) NSArray<TLMasterParam,ConvertOnDemand> *user_fans_list;

@end