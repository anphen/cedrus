//
//  TLDetailSubListData.h
//  tongle
//
//  Created by jixiaofei-mac on 15-6-4.
//  Copyright (c) 2015年 com.isoftstone. All rights reserved.
//

#import "JSONModel.h"

@protocol TLDetailSubListData <NSObject>


@end

@interface TLDetailSubListData : JSONModel

@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,strong) NSArray *sub_list;

@end
