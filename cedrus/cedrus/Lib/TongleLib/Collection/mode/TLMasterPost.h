//
//  TLMasterPost.h
//  tongle
//
//  Created by jixiaofei-mac on 15-7-1.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLPostParam.h"

@interface TLMasterPost : JSONModel

//数据总条数
@property (nonatomic,assign) NSString *data_total_count;
//帖子数据
@property (nonatomic,strong) NSArray<TLPostParam,ConvertOnDemand> *user_post_list;

@end
