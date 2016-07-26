//
//  TLDataList.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-4.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLSubListData.h"

@class TLDataList;

@protocol TLDataList <NSObject>

@end

@interface TLDataList : JSONModel

@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,strong) NSArray<TLDataList,ConvertOnDemand> *sub_list;


@end
