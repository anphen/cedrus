//
//  TLFriendsPostsAll.h
//  tongle
//
//  Created by liu ruibin on 15-5-8.
//  Copyright (c) 2015年 isoftstone. All rights reserved.
//

#import "JSONModel.h"
#import "TLPostParam.h"

@interface TLFriendsPostsAll : JSONModel

//数据总条数
@property (nonatomic,assign) NSString *data_total_count;
//我的关注帖子列表：帖子数据
@property (nonatomic,strong) NSArray<TLPostParam,ConvertOnDemand> *user_follow_post_list;


@end
