//
//  TLPostParamAll.h
//  tongle
//
//  Created by liu on 15-4-25.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLPostParam.h"
#import "JSONModel.h"

@interface TLPostParamAll : JSONModel

//数据总条数
@property (nonatomic,assign) NSString *data_total_count;
//我的关注帖子列表：帖子数据
@property (nonatomic,strong) NSArray<TLPostParam,ConvertOnDemand> *post_list;



@end
