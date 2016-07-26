//
//  TLSubListData.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-4.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLDetailSubListData.h"

@protocol TLSubListData <NSObject>

@end
@interface TLSubListData : JSONModel

@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,strong) NSArray<TLDetailSubListData,ConvertOnDemand> *sub_list;

@end
