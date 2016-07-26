//
//  TLMasterAllParam.h
//  tongle
//
//  Created by liu ruibin on 15-4-24.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLMasterParam.h"

@interface TLMasterAllParam : JSONModel

//数据总条数
@property (nonatomic,copy) NSString *data_total_count;


@property (nonatomic,strong) NSArray<TLMasterParam,ConvertOnDemand> *user_follow_friend_list;



@end
