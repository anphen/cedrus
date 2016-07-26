//
//  TLBaseDateType.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-4.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLDataList.h"

@protocol  TLBaseDateType

@end

@interface TLBaseDateType : JSONModel

@property (nonatomic,copy) NSString *base_data_type;
@property (nonatomic,strong) NSArray<TLDataList ,ConvertOnDemand> *data_list;



@end
